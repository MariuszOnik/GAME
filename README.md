Manual do projektu : GAME ENGINE LUA 2D NX

Spis treści
Wprowadzenie do architektury
Kluczowe komponenty systemu
Gamestate
BaseState
StateLoader
StateConfig
InputManager
CommandManager
MenuState
GameState
Przepływ działania systemu
Obsługa wejść i sygnałów
Ładowanie stanów gry
Dodawanie nowych stanów
Podsumowanie
1. Wprowadzenie do architektury
Nasza architektura opiera się na modułowym podejściu z użyciem sygnałów i stanów. Celem projektu jest stworzenie elastycznego systemu zarządzania stanami gry, z możliwością łatwego dodawania nowych stanów i kontrolowania interakcji za pomocą scentralizowanego menedżera wejść (InputManager).

Kluczowe elementy projektu to:

Leniwe ładowanie stanów: Stany są ładowane dopiero, gdy są potrzebne, co optymalizuje zarządzanie pamięcią.
Modularność: Każdy stan (np. MenuState, GameState) dziedziczy po BaseState i działa niezależnie, co ułatwia utrzymanie i rozszerzanie projektu.
Sygnały: Używamy sygnałów do komunikacji między różnymi komponentami, co pozwala na luźne powiązania między elementami systemu.
2. Kluczowe komponenty systemu
Gamestate
Biblioteka hump.gamestate zarządza przełączaniem się między różnymi stanami gry, takimi jak menu główne, edytor czy sama gra. Każdy stan implementuje własne funkcje takie jak enter, update i draw.

BaseState
BaseState to klasa bazowa, z której dziedziczą wszystkie stany gry. Odpowiada za wczytywanie konfiguracji i obsługę podstawowych funkcji, takich jak:

Wczytywanie plików konfiguracyjnych (np. .ini lub .lua z konfiguracją).
Rejestrowanie sygnałów wejściowych.
Ogólne funkcje, takie jak enter, update, i draw, które można nadpisywać w poszczególnych stanach.
StateLoader
StateLoader jest odpowiedzialny za leniwe ładowanie stanów. Zamiast ładować wszystkie stany na początku, są one ładowane dynamicznie z pliku konfiguracyjnego dopiero, gdy są potrzebne.

StateConfig
StateConfig przechowuje konfigurację wszystkich dostępnych stanów gry. Zawiera informacje o nazwach stanów, ścieżkach do plików, a także miejsce do przechowywania plików konfiguracyjnych dla każdego stanu.

InputManager
InputManager obsługuje wszystkie wejścia użytkownika, takie jak:

Klawiatura
Mysz
Joystick
Dotyk (na urządzeniach mobilnych lub Switchu)
Mapuje różne interakcje na polecenia, które są wykonywane przy pomocy wzorca polecenia.

CommandManager
CommandManager rejestruje i wykonuje komendy na podstawie interakcji wejściowych. Dzięki niemu możliwe jest elastyczne zarządzanie poleceniami bez silnych zależności między komponentami.

MenuState
MenuState to jeden z podstawowych stanów gry, odpowiadający za wybór innych stanów. Ładuje listę dostępnych stanów z pliku konfiguracyjnego i pozwala użytkownikowi wybrać stan, do którego chce przejść.

GameState
GameState to przykład stanu gry, w którym można zaimplementować logikę specyficzną dla danej gry. Dziedziczy on po BaseState i działa niezależnie od innych stanów.

3. Przepływ działania systemu
Start gry:

Gdy gra się uruchamia, plik main.lua przełącza się na MenuState, który zarządza wyborem stanu.
MenuState:

W MenuState użytkownik widzi listę dostępnych stanów (na podstawie StateConfig) i może nawigować między nimi przy pomocy klawiszy lub innych urządzeń wejściowych.
Przełączanie stanów:

Po wybraniu stanu, MenuState używa StateLoader, aby załadować wybrany stan i przełączyć się na niego.
Zarządzanie wejściami:

InputManager monitoruje wszystkie urządzenia wejściowe i odpowiednio reaguje na interakcje, emitując sygnały do odpowiednich komponentów.
4. Obsługa wejść i sygnałów
Wejścia w grze są scentralizowane w InputManagerze, który przetwarza:

Ruch kursora (mysz, joystick).
Kliknięcia przycisków (klawiatura, joystick).
Dotyk (na urządzeniach mobilnych/Switch).
Na przykład, naciśnięcie klawisza A może być zmapowane na polecenie move_left, które zostanie przekazane do CommandManager, a następnie wywołane w odpowiednim stanie gry.

Sygnały:
Sygnały są emitowane przez InputManager i przechwytywane przez inne komponenty. Przykład:

lua
Skopiuj kod
Signal.emit("move_left")
Signal.register("move_left", function() player:moveLeft() end)
5. Ładowanie stanów gry
Stany gry są ładowane dynamicznie za pomocą StateLoader. StateLoader korzysta z konfiguracji zawartej w pliku StateConfig, aby znaleźć i załadować odpowiedni stan w momencie, gdy użytkownik go wybierze.

Przykład z MenuState:

lua
Skopiuj kod
local selectedStateName = self.states[self.selectedState].name
Gamestate.switch(StateLoader.loadState(selectedStateName))
6. Dodawanie nowych stanów
Aby dodać nowy stan do gry, wystarczy:

Dodać nowy plik stanu do folderu GamesFolders.
Zarejestrować stan w pliku StateConfig.lua:
lua
Skopiuj kod
{ name = "NewGameState", path = "GamesFolders/NewGameState" }
MenuState automatycznie załaduje nowy stan i pozwoli użytkownikowi go wybrać.
7. Podsumowanie
Cały system jest zbudowany w sposób modułowy i łatwy do rozszerzenia. Stany gry są ładowane dynamicznie, wejścia użytkownika są zarządzane centralnie przez InputManager, a polecenia są rejestrowane i wykonywane przez CommandManager.

Dodawanie nowych stanów oraz interakcji jest proste i nie wymaga modyfikowania istniejącego kodu, co czyni projekt elastycznym i łatwym w utrzymaniu.


Wzorce projektowe i ich zastosowanie w projekcie
1. Wzorzec Stan (State Pattern)
Gdzie jest używany: Nasz system stanów, oparty na hump.gamestate, jest doskonałym przykładem wzorca Stan. Każdy stan, taki jak MenuState, GameState itp., reprezentuje inny tryb działania aplikacji, a przełączanie między nimi odbywa się dynamicznie w zależności od potrzeb użytkownika.
Dlaczego jest przydatny: Wzorzec ten pozwala na oddzielenie logiki każdego stanu, co czyni kod bardziej modularnym. Dzięki temu łatwo można dodawać nowe stany lub zmieniać istniejące, bez wpływu na inne części aplikacji.
2. Wzorzec Polecenia (Command Pattern)
Gdzie jest używany: CommandManager w połączeniu z InputManagerem implementuje wzorzec polecenia. Każda interakcja (np. naciśnięcie przycisku) jest mapowana na konkretne polecenie, które jest następnie przekazywane do odpowiedniego komponentu lub stanu.
Dlaczego jest przydatny: Dzięki temu wzorcowi można centralizować logikę wejść i poleceń, co upraszcza zarządzanie interakcjami. Nowe polecenia można dodawać bez modyfikowania istniejących mechanizmów, co zwiększa elastyczność i umożliwia rozbudowę projektu.
3. Wzorzec Obserwatora (Observer Pattern) / Sygnały
Gdzie jest używany: System sygnałów zaimplementowany za pomocą hump.signal to przykład wzorca obserwatora. Sygnały emitowane przez InputManager (np. move_left) są odbierane przez różne komponenty (np. obiekty w grze), które mogą reagować na te zdarzenia.
Dlaczego jest przydatny: Wzorzec obserwatora pozwala na luźne powiązanie między komponentami. Dzięki temu komponenty mogą komunikować się ze sobą bez bezpośrednich referencji, co zwiększa modularność i ułatwia rozbudowę systemu.
4. Wzorzec Leniwego Ładowania (Lazy Loading)
Gdzie jest używany: StateLoader implementuje leniwe ładowanie stanów. Stany są ładowane tylko wtedy, gdy są potrzebne, a nie od razu na początku.
Dlaczego jest przydatny: Optymalizuje zarządzanie zasobami i pamięcią. Dzięki temu unikamy ładowania wszystkich stanów gry naraz, co mogłoby być kosztowne, szczególnie w przypadku dużych projektów.
5. Wzorzec Singleton (Singleton Pattern)
Gdzie jest używany: Niektóre komponenty, takie jak InputManager, można traktować jako "prawie singletony". Są one tworzone tylko raz i zarządzają jedynym, globalnym stanem wejść w grze.
Dlaczego jest przydatny: Zapewnia centralizację zarządzania zasobami, co upraszcza kontrolowanie wejść w aplikacji.
Dlaczego nasz kod nie ma silnych powiązań i jest łatwy w rozwoju?
1. Sygnały i luźne powiązania
Dzięki wykorzystaniu wzorca obserwatora za pomocą sygnałów (hump.signal), komponenty mogą komunikować się między sobą bez bezpośredniego odniesienia do siebie nawzajem. Na przykład:

InputManager emituje sygnały (move_left, button_pressed), które są przechwytywane przez inne komponenty.
Każdy stan lub obiekt, który potrzebuje reagować na te sygnały, może się na nie zapisać, ale nie musi znać szczegółów działania InputManagera. To zwiększa modularność i ułatwia konserwację, ponieważ zmiany w jednym komponencie nie wymuszają modyfikacji w innych.
2. Modularne stany
Stany, takie jak MenuState i GameState, dziedziczą po klasie BaseState, co pozwala na wspólne zarządzanie podstawowymi funkcjami, takimi jak wczytywanie plików konfiguracyjnych, ale jednocześnie każdy stan ma własną logikę. To sprawia, że system jest bardziej elastyczny:

Można łatwo dodawać nowe stany bez modyfikacji istniejących.
Każdy stan działa niezależnie, co pozwala na testowanie i rozwijanie poszczególnych modułów osobno.
3. Wzorzec polecenia (Command Pattern)
Zastosowanie wzorca polecenia (CommandManager) pozwala na oddzielenie logiki wejść od logiki działania gry. Dzięki temu można wprowadzać nowe polecenia lub zmieniać mapowanie przycisków bez modyfikacji innych części systemu. Eliminuje to potrzebę silnych powiązań między modułami odpowiedzialnymi za obsługę wejść i logiką stanu gry.

4. Centralizacja wejść
InputManager działa jako centralny punkt, który zarządza wszystkimi wejściami (klawiatura, joystick, dotyk). Ponieważ wejścia są mapowane na komendy, możemy elastycznie zmieniać sposób obsługi różnych urządzeń bez konieczności modyfikowania kodu poszczególnych stanów. To centralizuje logikę wejść, ale jednocześnie nie tworzy silnych zależności.

5. Łatwe rozszerzanie i zmiana logiki
Zarówno StateLoader, jak i StateConfig umożliwiają dynamiczne zarządzanie stanami bez konieczności modyfikacji kodu głównego (main.lua). Dodawanie nowego stanu wymaga jedynie aktualizacji pliku konfiguracyjnego, a nie modyfikowania głównej logiki. To minimalizuje ryzyko wystąpienia błędów przy rozbudowie projektu.

Czy mamy silne powiązania w kodzie?
1. InputManager i CommandManager
Te dwie klasy są dość mocno ze sobą powiązane, ponieważ InputManager jest odpowiedzialny za wywoływanie poleceń w CommandManagerze. Choć jest to pewna zależność, jest ona kontrolowana i centralizowana w jednym miejscu, co zapobiega rozprzestrzenianiu się silnych powiązań na inne moduły. Aby uniknąć jeszcze większego powiązania, można by rozważyć bardziej zaawansowane zarządzanie poleceniami lub wprowadzenie abstrakcyjnej warstwy pomiędzy nimi, ale obecna implementacja jest wystarczająco modularna.

2. StateLoader i StateConfig
StateLoader jest w pełni zależny od StateConfig, ponieważ pobiera z niego informacje o stanach. Jednak jest to naturalna zależność wynikająca z samej struktury projektu. Ta zależność jest kontrolowana i nie wprowadza problemów z rozbudową projektu.

3. BaseState i dziedziczenie
Choć wszystkie stany dziedziczą po BaseState, nie tworzy to silnych powiązań, ponieważ logika w BaseState jest w dużej mierze podstawowa i wspólna dla wszystkich stanów. Dzięki temu dziedziczenie jest tutaj korzystne, a ewentualne modyfikacje nie wpływają negatywnie na resztę projektu.

Podsumowując, nasz projekt został zaprojektowany w sposób, który minimalizuje silne powiązania między modułami. Dzięki sygnałom, wzorcowi polecenia i modularnemu podejściu do stanów, łatwo jest go rozbudowywać, zmieniać i testować bez ryzyka wprowadzenia błędów w innych częściach systemu.
