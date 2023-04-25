# KubeCon 2023

This is my very first experience of KubeCon. I have been so excited since I got
the all access ticket in december 2022 which fortunately were quite affordable.
I have been working with Kubernetes for a while now and I was really looking
forward to meet the community and see what is going on around the world. And I
was not disappointed, it was a great experience talking to so many project
maintainers I have been following for some, contributed with and even met some
of colleagues from many different companies.

KubeCon 2023 was held in Amsterdam, Netherlands. Which was a great location with
a lot of great food and beer. The conference was held in the RAI Amsterdam
Convention Centre which was a great venue with a lot of space but still a lot
crowded at times. The conference was held over 3 days with 1 day of co-located
CNCF events including CiliumCon, Cloud Native WASM Day and a few others. The
other days were filled with keynotes, sessions, lightning talks and a lot of
hallway track.

## WASM didn't killed JavaScript yet

My first day at KubeCon was spent at the co-located events. I spent most of my
time looking around the Cloud Native WASM Day event, which I wasn't really
looking specifically for, even questioning what WASM was doing at a Kubernetes
event. But I was really surprised by the amount of projects and enthusiasm
around the topic growing after the cold reception it got a few years ago after
not killing JavaScript.

One of the first conference of the day was about "Evolution of WASM: Past,
Present Future" where I learned about the history of WASM after I gave up on it
after the first few years because of the lack of concrete use cases. But it
seems like the community has been growing a lot more on the server side than the
client side. Component Model was a new concept to me which is a way to build
applications with WASM modules. The idea is to build applications with a set of
modules that are isolated from each other and can be replaced similar but less
janky than system libraries such as OpenSSL or zlib ([C Isn't A Programming
Language Anymore](https://faultlore.com/blah/c-isnt-a-language)) using WIT
(WebAssembly Interface Types) with tools such as
[wit-bindgen](https://github.com/bytecodealliance/wit-bindgen/) and
[wasm-tools](https://github.com/bytecodealliance/wasm-tools/).

With a pinch of history, I learn few use cases from theses game developers folks
who where experimenting with WASM to port their games to the web such Angry Bots
in 2016 using Unity. But the most surprising use case was from the people at
Microsoft Flight Simulator who are using WASM as a plugin system principally for
the Xbox platform ([Programming APIs
WASM](https://docs.flightsimulator.com/html/Programming_Tools/WASM/WebAssembly.htm)).
I thought it was an interesting use case for many years since most performance
critical plugins were written in C++ and are not portable to other platforms,
while could crash the whole application at any time (Open Broadcaster Software
is a good example I have been working with).

The next talk was about "Serverless WebAssembly: Roundtrip Scaling from 0 to 10k
in 10 Seconds" by the Fermyon team. The idea is make serverless more efficient
and reactive than the current solutions such as AWS Lambda
([Firecracker](https://firecracker-microvm.github.io/)) or Google Cloud
([Knative](https://knative.dev/)) that rely on containers. The idea of using
WASM modules as the foundation is not new, Cloudflare has been doing it for a
while with [Cloudflare Workers](https://workers.cloudflare.com/) and Java itself
did it for many years. While I never really looked into it, I was unsurprised to
learn that the performance of the platform was impressive with isolation by
design, but the current state of the ecosystem was not really ready for
production yet, your favorite libraries are probably not available yet because
of the isolation principle. Such as Haskell, WASM is pure, blind, innocent, it
doesn't know about the environment around it unless you provide it with a way to
interact with it ([WASI](https://github.com/WebAssembly/WASI)).

## The service mesh stuffs

Let's talk about the elephant in the room, CiliumCon was a co-located event
about... Cilium, Yes you are right! You may have heard about it somehow if you
are working with Kubernetes. Cilium is the most popular networking plugin for
Kubernetes that took the community by storm a few years ago ([Try eBPF-powered
Cilium Service Mesh - join the beta
program!](https://cilium.io/blog/2021/12/01/cilium-service-mesh-beta/)). By
using eBPF to implement a sidecar-less networking model. Since I'm not a network
guy, I can't attest of the performance of the solution but it seems to be quite
a joy for many Kubernetes administrators. Sorry if you were looking forward to
this part, the only thing I know is that it now entered the service mesh war and
I'm quite excited to see what it will bring to the table compared to Istio which
is a bit of a pain to manage, upgrade and debug in production environment.

Talking about Istio, there have been 3 major fields of interest, the first was
around using [SPIFFE](https://spiffe.io/) and
[SPIRE](https://github.com/spiffe/spire) as a standard and interoperable way to
manage service identity and mTLS in Kubernetes cluster using X.509 certificates.
That was not only about Istio, Google Cloud or AWS, but an identity lingua franca
for all service mesh and clouds.

The second was about the Gateway API, a lot, A LOT during the whole convention.
This Kubernetes SIG project specify a way to manage ingress and egress traffic
in a Kubernetes cluster. For many years we had few options, either use the
built-in ingress, use a third party such as Traefik or Nginx or use a service
mesh such as Istio. Compared to other solutions, Gateway API play nicely with
the cloud provider by mapping the specification to the host services such as
[AWS VPC Lattice](https://aws.amazon.com/vpc/lattice/) while also solving the
double hop network problem.

The third was Ambient Mesh, the hybrid response to Cilium. Because eBPF alone is
not yet really great at handling the L7 side of the network stack, it is not
really possible to do things such as rate limiting or circuit breaking. Istio
introduced Ztunnel ([Introducing Rust-Based Ztunnel for Istio Ambient Service
Mesh](https://istio.io/latest/blog/2023/rust-based-ztunnel/)) agent to offload
many L4 operations from the sidecar such as the mTLS to reduce the
infrastructure cost.

## It's running hot here

The next major topic of the convention was about HPC (High Performance
Computing). If I had to make a tl;dr it would be "GPU are great, but they are
pain to share". The CERN team talked about how they have been experimenting with
time slicing GPU to share them between multiple users, it seems like it is
working quite well but the drawback is that it is not really possible to isolate
memory from the different users which can lead to starvation then if you are a
Machine Learning engineer you know what happen: it crash spectacularly and you
didn't checkpoints. The performance penalty is also non-negligible because of
the context switch between the different users. Another ideas have been explored
in the MIG (Multi Instance GPU) side of things. The difference is that the GPU
is truly sliced into multiple virtual GPU that can be assigned to different
users but any re-partitioning need a complete processes eviction. The
performance penalty is still there at around 9.25% of core and stream processor
while it only work on Ampere and Hopper series of GPU.

## Red Light is not only a state

I didn't spent much time in the Delivery Management side of the convention, but
I had to mention how much this space have been gigantically growing in the last
few years. As mentioned in the keynote, this side have seen the most projects
submission among all the other side of the CNCF. It is not a surprise that
ArgoCD is king of the hill, it is the singular project that I have heard about
the most in all conversations I had during the convention. It even had its own
co-located event!

[KubeVela](https://kubevela.io/) is a new project that I never heard about
before, it is a tool that helps you to manage your Kubernetes application by
providing a higher level abstraction on top of the Kubernetes API. It is in
between Operators and Helm, is not as complex as Operators but it doesn't
require the same level of expertise as Helm. It is a great tool to help you
create a sane interface for your Kubernetes administrators and developers
without learning the infrastructure implementation details.

But, but, but, how about development cycle ? My favorite topic have always been
about how to make the development experience better and therefore you and me
happy ([You don’t have to ship your computer anymore
](https://www.linkedin.com/pulse/you-dont-have-ship-your-computer-anymore-william-phetsinorath/)).
But I have been navigating the Kubernetes ecosystem with this frustration of not
being able to iterate fast enough on my code. GitOps is a great way to manage
your infrastructure, it is not really a great way to test things fast, similar
to git pushing every time for the sake of testing if your Terraform code is
working but that's a whole other topic.

[Skaffold](https://skaffold.dev/) is a tool that I have been using for as long
as it existed, it is a tool that helps you to build, push and deploy your code
and dependent systems to Kubernetes in a single command: skaffold dev. And yes,
that's it, I never found anything better even though it is not perfect. Until
maybe [Telepresence](https://www.telepresence.io/)? One the project that I found
out at the convention, it is a tool that allows you to run a local process like
in a Kubernetes cluster. It is a bit like a reverse proxy that intercepts the
traffic and redirect it to your local process, yes imagine a world where you
don't have to build and push your code to test it.

## Conclusion

As a complete side note, Boston Dynamics Spot robot use gRPC to communicate with
the controller. I was really surprised to see that, I was expecting something
weirder. Now you know, maybe someday this information will be useful.

The experience was great, this is a great place to meet people from the
community and learn about what is going on in the industry. While it is a big
investment, I think it could be worth it if you are working with Kubernetes or
Cloud Native technologies.

I would like to thank myself for YOLOing this trip and the many maintainers that
took the time to talk to me about their projects.

I hope to see you there next time!
