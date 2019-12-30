#include <iostream>
#include "ftxui/dom/elements.hpp"
#include "ftxui/screen/screen.hpp"
#include "ftxui/screen/string.hpp"

int main(void) {
  using namespace ftxui;

  auto summary = [&]{
    return
      window(text(L" Summary "),
        vbox(
          hbox(text(L"- done:   "), text(L"3") | bold) | color(Color::Green),
          hbox(text(L"- active: "), text(L"2") | bold) | color(Color::RedLight),
          hbox(text(L"- queue:  "), text(L"9") | bold) | color(Color::Red)
        )
      );
  };

  auto document =
    vbox(
      hbox(
        summary(),
        summary(),
        summary() | flex
      ),
      summary(),
      summary()
    );
  
  // Limit the size of the document to 80 char.
  document = std::move(document) | size(WIDTH, LESS_THAN, 80);

  auto screen = Screen::Create(Dimension::Full(), Dimension::Fit(document));
  Render(screen, document.get());
  std::cout << screen.ToString() << std::endl;

  return EXIT_SUCCESS;
}
