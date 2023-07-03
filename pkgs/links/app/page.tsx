import Image from "next/image";

export default function Home() {
  return (
    <div className="hero min-h-screen bg-black">
      <div className="hero-content flex-col space-y-4">
        <div className="mt-16">
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
        </div>

        <div className="text-center">
          <h2 className="text-2xl font-mono font-bold text-white">
            @Shikanime
          </h2>
          <p className="mt-2 font-mono text-white">
            もう一度人生を楽しくしましょう
          </p>
        </div>

        <a href="https://twitter.com/shikalegend" className="no-underline">
          <div className="w-full btn btn-primary btn-circle">🦜 Twitter</div>
        </a>
        <a href="https://github.com/shikanime" className="no-underline">
          <div className="w-full btn btn-primary btn-circle">💾 Github</div>
        </a>
        <a
          href="https://linkedin.com/williamphetsinorath"
          className="no-underline"
        >
          <div className="w-full btn btn-primary btn-circle">🗺️ LinkedIn</div>
        </a>
        <a
          href="https://myanimelist.net/profile/Shikalegend"
          className="no-underline"
        >
          <div className="w-full btn btn-primary btn-circle">
            🎏 MyAnimeList
          </div>
        </a>
      </div>
    </div>
  );
}
