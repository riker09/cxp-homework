export const generateRandomRegistryNumber = (len = 4) => {
  let num: number;
  let str: string;

  do {
    str = Math.random()
      .toString()
      .substring(2, 2 + len);
    num = Number.parseInt(str);
  } while (str.substring(0, 1) === "0");

  return num;
};

const suffixes = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

export const rnd = (len = 1) => {
  let r = Math.random()
    .toString()
    .substring(2, 2 + len);
  while (r.substring(0, 1) === "0") {
    r = Math.random()
      .toString()
      .substring(2, 2 + len);
  }
  return Number.parseInt(r);
};

export const generateSuffix = () => {
  const steps = suffixes.length - 1;
  let r: number;
  let p = 0.5;
  let i = 0;
  let x = false;
  do {
    r = Math.random();
    x = r < p + (i * (1 - p)) / steps;
    i++;
  } while (!x);
  return `-${suffixes.substring(i, i + 1)}`;
};
