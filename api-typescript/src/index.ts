import express from "express";
import { generateRandomRegistryNumber, generateSuffix } from "./helper";

const app = express();
const port = process.env.PORT || 8080;

const PROBABILITY_TO_GENERATE_FIVE_NUMBERS = 0.2;
const PROBABILITY_TO_GENERATE_LETTER_SUFFIX = 0.3;

app.get("/", (req, res) => {
  const qPrefix = req.query["prefix"];
  const qLength = req.query["len"] || req.query["length"];
  const qProto =
    !!req.query["proto"] &&
    !["false", "null", "0"].includes(`${req.query["proto"]}`);

  // Prefix
  const prefix = qPrefix || (qProto ? "NX-0" : undefined) || "NCC-";

  // Length of registry number if specified, 1 if prototype, or random(4,5)
  const len =
    Number.parseInt(`${qLength}`, 10) ||
    (qProto ? 1 : undefined) ||
    (Math.random() < PROBABILITY_TO_GENERATE_FIVE_NUMBERS ? 5 : 4);

  const number = generateRandomRegistryNumber(len);

  // Add a suffix (-A, -B, ...), when no prototype number was requested
  let suffix =
    !qProto && Math.random() < PROBABILITY_TO_GENERATE_LETTER_SUFFIX
      ? generateSuffix()
      : "";

  res.send(`${prefix}${number}${suffix}`);
});

app.listen(port, () => {
  console.log(`Listening on ${port}...`);
});
