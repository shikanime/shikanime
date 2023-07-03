import Image from "next/image";

export default function Home() {
  return (
    <div className="hero min-h-screen">
      <div className="hero-content text-center flex-col space-y-4">
        <Image
          src="/logo.webp"
          alt="avatar#user"
          width={150}
          height={150}
          className="mx-auto"
        />
        <div className="max-w-md">
          <h1 className="text-5xl font-bold">Infinity Horizons</h1>
          <p className="py-6">
            Where ideas collide and imagination soars, we are proud dreamers on
            the mission to make them a reality.
          </p>
        </div>
      </div>
    </div>
  );
}
