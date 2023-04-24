# KubeCon 2023

This is my very first experience of KubeCon. I have been so exited since I got
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
CNCF events including CiliumConn, Cloud Native WASM Day and a few others. The
other days were filled with keynotes, sessions, lightning talks and a lot of
hallway track.

## WASM didn't killed JavaScript yet

My first day at KubeCon was spent at the co-located events. I spent most of my
time looking around the Cloud Native WASM Day event, which I wasn't really
looking specifically for, even questioning what WASM was doing at a Kubernetes
event. But I was really surprised by the amount of projects and enthusiasm
around the topic growing after the cold reception it got a few years ago after
not killing JavaScript.

One of thes first conference of the day was about "Evolution of WASM: Past,
Present Future" where I learned about the history of WASM after I gave up on it
after the first few years because of the lack of concreate use cases. But it
seems like the community has been growing a lot more on the server side than the
client side. Component Model was a new concept to me which is a way to build
applications with WASM modules. The idea is to build applications with a set of
modules that are isolated from each other and can be replaced similar but less
janky than system libraries such as OpenSSL or zlib using WIT (WebAssembly
Interface Types) with tools such as wit-bindgen and wasm-tools.

With a pinch of history, I learn few use cases from theses game developers folks
who where experimenting with WASM to port their games to the web such Angry Bots
in 2016 using Unity. But the most suprising use case was from the people at
Microsoft Flight Simulator who are using WASM as a plugin system principally for
the Xbox platform. I tough it was an interesting use case for many years since
most performance critical plugins were written in C++ and are not portable to
other platforms, while could crash the whole application at any time (Open
Broadcaster Software is a good exemple I have been working with).

The next talk was about "Serverless WebAssemby: Roundtrip Scaling from 0 to 10k
in 10 Seconds" by the Fermyon team. The idea is make serverless more efficient
and reactive than the current solutions such as AWS Lambda or Google Cloud that
rely on containers. The idea is to use WASM modules as the foundation is not
new, Cloudflare has been doing it for a while with Cloudflare Workers. While I
never really looked into it, I was unsuprised to learn that the performance of
the platform was good but the current state of the ecosystem was not really
ready for production yet, your favorite libraries are probably not available
yet.

## The service mesh stuffs

Let's talk about the elephant in the room, CiliumConn was a co-located event
about... Cilium, Yes you are right! You may have heard about it somehow if you
are working with Kubernetes. Cilium is the most popular a networking plugin for
Kubernetes that took the community by storm a few years ago. By using eBPF to
implement a sidecar-less networking model. Since I'm not a network guy, I can't
attest of the performance of the solution but it seems to be quite a joy for
many Kubenernetes administrators. Sorry if you were looking forwart to this
part, the only thing I know is that it now enterred the service mesh war and I'm
quite exited to see what it will bring to the table compared to Istio which is a
bit of a pain to manage, upgrade and debug.

Talking about Istio, there have been 3 major fields of interest, the first was
around using SPIFFE and SPIRE as a standard and interoperable way to manage
service identity and mTLS in Kubernetes cluster using X.509 certificates. That
was not only about Istio, Google Cloud or AWS, but a identity lingua franca for
all service mesh solutions.

The second was about the Gateway API, a lot, A LOT during the whole convention.
This Kubernetes SIG project specify a way to manage ingress and egress traffic
in a Kubernetes cluster. For many years we had few options, either use the
built-in ingress, use a third party such as Traefik or Nginx or use a service
mesh such as Istio. Compared to the other solution, Gateway API nicely map to
the cloud provider services such AWS VPC Lattice while also solving the double
hop network problem.

The third was Ambient Mesh, the hybrid response to Cilium. Because eBPF alone is
not yet really great at handling the L7 side of the network stack, it is not
really possible to do things such as rate limiting or circuit breaking. Istio
introduced ztunnel agent to offload many L4 operations from the sidecar such as
the mTLS to reduce the infrastructure cost.

## Accelerators are not only for mining

The next major topic of the convention was about HPC (High Performance
Computing). If I had to make a tl;dr it would be "GPU are great, but they are
pain to share". The CERN team talked about how they have been experimenting with
time slicing GPU to share them between multiple users, it seems like it is
working quite well but the drawback is that it is not really possible to isolate
memory from the different users which can lead to starvation then crash. The
performance penalty is also non-negligible because of the context switch between
the different users.

Another ideas have been explored in the MIG (Multi Instance GPU) side of things.
The difference is that the GPU is truly sliced into multiple virtual GPU that
can be assigned to different users and any repartition need a complete processes
eviction. The performance penalty is still there at around 9.25% of core and
stream processor while it only work on Ampere and Hopper series of GPU.

## Conclusion

As a complete side note, Boston Dynamics Spot robot use gRPC to communicate with
the controller. I was really surprised to see that, I was expecting something
weirder. Now you know, maybe someday it'll be usefull.

The experience was great, this is a great place to meet people from the
community and learn about what is going on in the industry. While it could be
a big investment, I think it is worth it if you are working with Kubernetes or
Cloud Native technologies.

I would like to thank myself for YOLOing this trip and the many maintainers
that took the time to talk to me about their projects.

I hope to see you there next year!
