/// A custom JSON type
export type CustomJSON =
  | string
  | number
  | boolean
  | null
  | {[key: string]: CustomJSON | undefined}
  | {[key: string]: any}
  | CustomJSON[];
