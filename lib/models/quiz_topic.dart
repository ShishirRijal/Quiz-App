class QuizTopic {
  final String id;
  final String title;
  final String image;
  final String description;
  final String route;

  QuizTopic({
    required this.id,
    required this.title,
    required this.image,
    required this.description,
    required this.route,
  });
}

List<QuizTopic> quizTopic = [
  QuizTopic(
    id: "operating-systems",
    title: "Operating System",
    image:
        "https://www.freecodecamp.org/news/content/images/2021/08/uide-to-writting-a-good-readme-file--6-.png",
    description:
        "An operating system (OS) is system software that manages computer hardware and software resources and provides common services for computer programs. All computer programs, excluding firmware, require an operating system to function.",
    route: "/operating-system",
  ),
  QuizTopic(
    id: "computer-networks",
    title: "Computer Network",
    image:
        "https://previews.123rf.com/images/cooldesign/cooldesign1305/cooldesign130500248/19647930-global-computer-network-on-abstract-background.jpg",
    description:
        "A computer network is a digital telecommunications network which allows nodes to share resources. In computer networks, computing devices exchange data with each other using connections (data links) between nodes. These data links are established over cable media such as wires or optic cables, or wireless media such as Wi-Fi.",
    route: "/computer-network",
  ),
  QuizTopic(
    id: "flutter",
    title: "Flutter",
    image:
        "https://koenig-media.raywenderlich.com/uploads/2021/10/Teaching_Dash_.png",
    description:
        "Flutter is an open-source UI software development kit created by Google. It is used to develop applications for Android, iOS, Linux, Mac, Windows, Google Fuchsia, and the web from a single codebase.",
    route: "/flutter",
  ),
  QuizTopic(
    id: "dart-lang",
    title: "Dart",
    image: "https://res.infoq.com/presentations/Dart/en/slides/1.jpg",
    description:
        "Dart is a client-optimized programming language for apps on multiple platforms. It is developed by Google and is used to build mobile, desktop, server, and web applications. Dart is an object-oriented, class-based, garbage-collected language with C-style syntax. Dart can compile to either native code or JavaScript.",
    route: "/dart",
  ),
  QuizTopic(
    id: "C++_programming",
    title: "C++",
    image:
        "https://bs-uploads.toptal.io/blackfish-uploads/components/blog_post_page/content/cover_image_file/cover_image/1080335/retina_1708x683_cover-0325-LearnCandC__Languages_Dan_Newsletter-743100f051077054fa1cc613ff4523a2.png",
    description:
        "C++ is a general-purpose programming language created by Bjarne Stroustrup as an extension of the C programming",
    route: "/C++",
  ),
  QuizTopic(
    id: "microprocessor",
    title: "Microprocessor",
    image:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTHYcDwWIMnf2I3L58ewzjYhcJxpDO4V5Ow3g&usqp=CAU",
    description:
        "A microprocessor is a computer processor that incorporates the functions of a central processing unit on a single integrated circuit (IC), or at most a few integrated circuits. Microprocessors contain both combinational logic and sequential digital logic. Microprocessors operate on numbers and symbols represented in the binary numeral system.",
    route: "/microprocessor",
  ),
  QuizTopic(
      id: "cyber-security",
      title: "Cyber Security",
      image:
          "https://www.simplilearn.com/ice9/free_resources_article_thumb/Top_Cybersecurity_Projects.jpg",
      description:
          "Cybersecurity is the practice of protecting systems, networks, and programs from digital attacks. These cyberattacks are usually aimed at accessing, changing, or destroying sensitive information; extorting money from users; or interrupting normal business processes.",
      route: "/cyber-security"),
  QuizTopic(
      id: "ui-ux",
      title: "UI/UX",
      image:
          "https://img.freepik.com/free-vector/gradient-ui-ux-background_23-2149052117.jpg?w=2000",
      description:
          "UI/UX is the process of enhancing user satisfaction by improving the usability, accessibility, and pleasure provided in the interaction between the user and the product. The goal of UI/UX design is to make the product easy to use and pleasurable. ",
      route: "/ui-ux"),
];
