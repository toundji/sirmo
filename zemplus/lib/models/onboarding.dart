class Onboarding {
  late String title;
  late String content;
  late String image;
  bool isSvg = false;
  Onboarding({
    required this.title,
    required this.content,
    required this.image,
    this.isSvg = false,
  });

  static Onboarding get first {
    return Onboarding(
        title: "Conducteur",
        content: "Obtenez votre licence de conduire en un clique",
        image: "assets/images/onboarding-first.gif",
        isSvg: false);
  }

  static Onboarding get second {
    return Onboarding(
        title: "Mairie",
        content:
            "Obtenez les informations sur les conducteurs de votre commune",
        image: "assets/images/onboarding-second.gif");
  }

  static Onboarding get third {
    return Onboarding(
        title: "Police",
        content:
            "Controllez les conducteurs à partir de votre assistant mobile",
        image: "assets/images/onboarding-third.gif");
  }
}
