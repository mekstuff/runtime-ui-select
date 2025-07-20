declare const color3: {
    new: (r: number | Color3, g: number, b: number, alpha?: number) => Color3;
    fromRGB: (r: number, g: number, b: number, alpha?: number) => Color3;
    fromHSV: (h: number, s: number, v: number, alpha?: number) => Color3;
};
export = color3;
