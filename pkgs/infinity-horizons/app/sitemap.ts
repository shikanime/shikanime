import { MetadataRoute } from "next";

export default function sitemap(): MetadataRoute.Sitemap {
  return [
    {
      url: "https://infinityhorizons.shikanime.studio",
      lastModified: new Date(),
    },
  ];
}
