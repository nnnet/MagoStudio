import type { MagoDesktopApi } from "../../desktop/shared/contracts";

export const isLocalApp = process.env.NEXT_PUBLIC_MAGO_STUDIO === "true";
export const OPEN_CREDENTIALS_EVENT = "mago:open-credentials";

export const getLocalDesktopApi = (): MagoDesktopApi => ({
  account: { mode: "offline" },
  projects: { get: () => Promise.resolve(null) }
}) as any;
