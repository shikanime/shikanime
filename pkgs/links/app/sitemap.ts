import { MetadataRoute } from "next";

export default function sitemap(): MetadataRoute.Sitemap {
  return [
    {
      url: "https://links.shikanime.studio",
      lastModified: new Date(),
    },
  ];
}
