import Image from "next/image";

export default function Home() {
  return (
    <div className="hero min-h-screen bg-gradient-to-br from-purple-600 to-yellow-200">
      <div className="hero-content flex-col space-y-4">
        <div className="mt-16">
          <label className="swap">
            <input type="checkbox" />
            <div className="swap-on">
              <Image
                src="/avatar-swap.png"
                alt="avatar#user"
                width={150}
                height={150}
                className="rounded-full border-2 border-white"
              />
            </div>
            <div className="swap-off">
              <Image
                src="/avatar.png"
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

        <div className="w-full btn btn-primary btn-circle">
          <a href="https://twitter.com/shikalegend" className="no-underline">
            🦜 Twitter
          </a>
        </div>
        <div className="w-full btn btn-primary btn-circle">
          <a href="https://github.com/shikanime" className="no-underline">
            💾 Github
          </a>
        </div>
        <div className="w-full btn btn-primary btn-circle">
          <a
            href="https://linkedin.com/williamphetsinorath"
            className="no-underline"
          >
            🗺️ LinkedIn
          </a>
        </div>
        <div className="w-full btn btn-primary btn-circle">
          <a
            href="https://myanimelist.net/profile/Shikalegend"
            className="no-underline"
          >
            🎏 MyAnimeList
          </a>
        </div>
      </div>
    </div>
  );
}
