import express from "express";
import { generateRandomRegistryNumber, generateSuffix } from "./helper";

const app = express();
const port = 3001;

const PROBABILITY_TO_GENERATE_FIVE_NUMBERS = 0.2;
const PROBABILITY_TO_GENERATE_LETTER_SUFFIX = 0.3;

app.get("/", (req, res) => {
  // Generate random registry number with 4 or 5 characters
  const len = Math.random() < PROBABILITY_TO_GENERATE_FIVE_NUMBERS ? 5 : 4;
  const number = generateRandomRegistryNumber(len);

  // Add a suffix (-A, -B, ...)
  let suffix = "";
  if (Math.random() < PROBABILITY_TO_GENERATE_LETTER_SUFFIX) {
    suffix = `-${generateSuffix()}`;
  }

  res.send(`NCC-${number}${suffix}`);
});

app.listen(port, () => {
  console.log(`Listening on ${port}...`);
});
