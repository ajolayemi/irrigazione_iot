/**
 *
 * @param daysAgo The number of days to subtract from current date. Defaults to 7
 * @returns The result
 */
export const getDaysAgo = (daysAgo?: number): Date => {
  const currentTime = new Date(Date.now());
  const sevenDaysAgo = currentTime;
  sevenDaysAgo.setDate(sevenDaysAgo.getDate() - (daysAgo ?? 7));
  sevenDaysAgo.setHours(0, 0, 0, 0);

  return sevenDaysAgo;
};

export const buildDateForFileName = (date: Date): string => {
  return date.toISOString().split("T")[0].replace(/[-]/g, "_");
};


export const buildArchiveFileFullName = (date: Date, prefix: string, extension?: string) => {
    const dateForFile = buildDateForFileName(date);
    return `${prefix}_${dateForFile}.${extension ?? 'csv'}`;
}