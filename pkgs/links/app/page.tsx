import Image from "next/image";

export default function Home() {
  return (
    <div className="hero min-h-screen">
      <div className="hero-content flex-col space-y-2 my-4">
        <label className="swap">
          <input type="checkbox" />
          <div className="swap-on">
            <Image
              src="/avatar-happy.webp"
              alt="avatar-happy#user"
              width={150}
              height={150}
              className="rounded-full border-2 border-white"
            />
          </div>
          <div className="swap-off">
            <Image
              src="/avatar.webp"
              alt="avatar#user"
              width={150}
              height={150}
              className="rounded-full border-2 border-white"
            />
          </div>
        </label>

        <div className="text-center">
          <h2 className="text-2xl font-mono font-bold text-white">
            @Shikanime
          </h2>
          <p className="mt-2 font-mono text-white">
            もう一度人生を楽しくしましょう
          </p>
        </div>

        <a
          href="https://github.com/shikanime"
          className="w-full btn btn-primary btn-circle"
        >
          💾 Github
        </a>
        <a
          href="https://linkedin.com/in/williamphetsinorath"
          className="w-full btn btn-primary btn-circle"
        >
          🗺️ LinkedIn
        </a>
        <a
          href="https://myanimelist.net/profile/Shikalegend"
          className="w-full btn btn-primary btn-circle"
        >
          🎏 MyAnimeList
        </a>
      </div>
    </div>
  );
}
