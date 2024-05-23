module.exports = {
  root: true,
  env: {
    es6: true,
    node: true,
  },
  extends: [
    "eslint:recommended",
    "plugin:import/errors",
    "plugin:import/warnings",
    "plugin:import/typescript",
    "google",
    "plugin:@typescript-eslint/recommended",
  ],
  parser: "@typescript-eslint/parser",
  parserOptions: {
    project: ["tsconfig.json", "tsconfig.dev.json"],
    sourceType: "module",
  },
  ignorePatterns: [
    "/lib/**/*", // Ignore built files.
  ],
  plugins: ["@typescript-eslint", "import"],
  rules: {
    "@typescript-eslint/no-explicit-any": "off",
    quotes: ["error", "double"],
    "quote-props": ["error", "as-needed"],
    "import/no-unresolved": 0,
    "linebreak-style": 0,
    "max-len": [
      "error",
      {
        code: 110,
        comments: 120,
        ignorePattern: "^\\s*import|^\\s*export|^\\s*return|^\\s*logger",
      },
    ],
    indent: ["error", 2],
  },
};
