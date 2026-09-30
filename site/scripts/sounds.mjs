// Packs each switch in ../Sounds into one mono WAV for the browser (public/sounds/<slug>.wav)
// and writes the offsets to src/data/packs.json.
import { mkdirSync, readdirSync, readFileSync, rmSync, writeFileSync } from "node:fs";
import { join } from "node:path";

const SOURCE = "../Sounds";
const RATE = 48_000;
const TYPES = { "MX Black": "Linear", "MX Red": "Linear", "MX Brown": "Tactile", "MX Blue": "Clicky", Topre: "Electro-capacitive" };
const ORDER = ["MX Brown", "MX Black", "MX Red", "MX Blue", "Topre"];

function readWav(path) {
  const buf = readFileSync(path);
  let offset = 12;
  let channels = 0;
  while (offset < buf.length) {
    const id = buf.toString("ascii", offset, offset + 4);
    const size = buf.readUInt32LE(offset + 4);
    if (id === "fmt ") channels = buf.readUInt16LE(offset + 10);
    if (id === "data") {
      const frames = size / 2 / channels;
      const mono = new Int16Array(frames);
      for (let i = 0; i < frames; i++) {
        let sum = 0;
        for (let c = 0; c < channels; c++) sum += buf.readInt16LE(offset + 8 + (i * channels + c) * 2);
        mono[i] = Math.round(sum / channels);
      }
      return mono;
    }
    offset += 8 + size + (size % 2);
  }
  throw new Error(`no data chunk in ${path}`);
}

function writeWav(path, samples) {
  const header = Buffer.alloc(44);
  header.write("RIFF", 0);
  header.writeUInt32LE(36 + samples.byteLength, 4);
  header.write("WAVEfmt ", 8);
  header.writeUInt32LE(16, 16);
  header.writeUInt16LE(1, 20);
  header.writeUInt16LE(1, 22);
  header.writeUInt32LE(RATE, 24);
  header.writeUInt32LE(RATE * 2, 28);
  header.writeUInt16LE(2, 32);
  header.writeUInt16LE(16, 34);
  header.write("data", 36);
  header.writeUInt32LE(samples.byteLength, 40);
  writeFileSync(path, Buffer.concat([header, Buffer.from(samples.buffer)]));
}

rmSync("public/sounds", { recursive: true, force: true });
mkdirSync("public/sounds", { recursive: true });
mkdirSync("src/data", { recursive: true });

const names = readdirSync(SOURCE).sort((a, b) => ORDER.indexOf(a) - ORDER.indexOf(b));
const packs = names.map((name) => {
  const slug = name.toLowerCase().replace(/\s+/g, "-");
  const parts = [];
  const offsets = { press: {}, release: {} };
  let cursor = 0;
  for (const action of ["press", "release"]) {
    for (const file of readdirSync(join(SOURCE, name, action)).filter((f) => f.endsWith(".wav"))) {
      const samples = readWav(join(SOURCE, name, action, file));
      offsets[action][file.slice(0, -4)] = [cursor / RATE, samples.length / RATE];
      parts.push(samples);
      cursor += samples.length;
    }
  }
  const sprite = new Int16Array(cursor);
  let at = 0;
  for (const p of parts) {
    sprite.set(p, at);
    at += p.length;
  }
  writeWav(`public/sounds/${slug}.wav`, sprite);
  return {
    name,
    slug,
    type: TYPES[name] ?? "",
    ...offsets,
  };
});

writeFileSync("src/data/packs.json", JSON.stringify(packs));
console.log(`sounds: ${packs.map((p) => p.name).join(", ")}`);
