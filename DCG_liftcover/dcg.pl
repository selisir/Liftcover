:- use_module(library(liftcover)).

:- if(current_predicate(use_rendering/1)).
:- use_rendering(c3).
:- use_rendering(lpad).
:- endif.

:- lift.

:- set_lift(max_iter, 25).
:- set_lift(megaex_bottom, 15).
:- set_lift(initial_clauses_per_megaex, 2).
:- set_lift(min_probability, 0.05).


% ---- BACKGROUND -----
:- begin_bg.
    % Lexicon
    proper_noun(john). proper_noun(annie). proper_noun(monet).
    common_noun(man). common_noun(woman).
    noun(X) :- proper_noun(X).
    noun(X) :- common_noun(X).
    quantifier(every). quantifier(a).
    transitive_verb(likes). transitive_verb(admires).
    intransitive_verb(paints).
    verb(X) :- transitive_verb(X).
    verb(X) :- intransitive_verb(X).
    relative_pronoun(that).

   
    word_at(Pos, Word) :- s_has_term(_, Pos, Word, _).
    
    sentence_len(L) :- 
        findall(P, s_has_term(_, P, _, _), Ls),
        length(Ls, L).
    
    % PREDICATO PER LA STRTTURA DELLA FRASE
    first_word(W) :- word_at(1, W).
    second_word(W) :- word_at(2, W).
    third_word(W) :- word_at(3, W).
    fourth_word(W) :- word_at(4, W).
    
    % PER LA POSIZIONE
    consecutive_words(P1, W1, W2) :-
        P2 is P1 + 1,
        word_at(P1, W1),
        word_at(P2, W2).
    
    
    np_proper_at(Pos) :- word_at(Pos, W), proper_noun(W).
    
    
    np_quant_at(Pos) :-
        word_at(Pos, Q), quantifier(Q),
        Pos2 is Pos + 1,
        word_at(Pos2, N), common_noun(N).
    
    
    vp_intrans_at(Pos) :- word_at(Pos, V), intransitive_verb(V).
   
    vp_trans_at(Pos) :-
        word_at(Pos, V), transitive_verb(V),
        NPPos is Pos + 1,
        (np_proper_at(NPPos); np_quant_at(NPPos)).
:- end_bg.

%--- TYPE DEFINITIONS ---
in(pos, [1, 2, 3, 4, 5, 6, 7]).
in(word, [john, annie, monet, man, woman, every, a, likes, admires, paints, that]).

input(proper_noun/1).
input(common_noun/1).
input(transitive_verb/1).
input(intransitive_verb/1).
input(noun/1).
input(verb/1).
input(quantifier/1).
input(relative_pronoun/1).
input(word_at/2).
input(sentence_len/1).
input(first_word/1).
input(second_word/1).
input(third_word/1).
input(fourth_word/1).
input(consecutive_words/3).
input(np_proper_at/1).
input(np_quant_at/1).
input(vp_intrans_at/1).
input(vp_trans_at/1).

output(grammatical/0).


% ----- MODE DECLARATIONS -----
modeh(*, grammatical).

% Basic word position patterns
modeb(*, word_at(1, -word)).
modeb(*, word_at(2, -word)).
modeb(*, word_at(3, -word)).
modeb(*, word_at(4, -word)).
modeb(*, first_word(-word)).
modeb(*, second_word(-word)).
modeb(*, third_word(-word)).
modeb(*, fourth_word(-word)).

% Lexical categories
modeb(*, proper_noun(+word)).
modeb(*, common_noun(+word)).
modeb(*, noun(+word)).
modeb(*, quantifier(+word)).
modeb(*, transitive_verb(+word)).
modeb(*, intransitive_verb(+word)).
modeb(*, verb(+word)).
modeb(*, relative_pronoun(+word)).

% Structural patterns
modeb(*, consecutive_words(#pos, -word, -word)).
modeb(*, sentence_len(#pos)).

% High-level phrase structure
modeb(*, np_proper_at(#pos)).
modeb(*, np_quant_at(#pos)).
modeb(*, vp_intrans_at(#pos)).
modeb(*, vp_trans_at(#pos)).

% Determinations
determination(grammatical/0, word_at/2).
determination(grammatical/0, first_word/1).
determination(grammatical/0, second_word/1).
determination(grammatical/0, third_word/1).
determination(grammatical/0, fourth_word/1).
determination(grammatical/0, proper_noun/1).
determination(grammatical/0, common_noun/1).
determination(grammatical/0, noun/1).
determination(grammatical/0, verb/1).
determination(grammatical/0, transitive_verb/1).
determination(grammatical/0, intransitive_verb/1).
determination(grammatical/0, quantifier/1).
determination(grammatical/0, relative_pronoun/1).
determination(grammatical/0, sentence_len/1).
determination(grammatical/0, consecutive_words/3).
determination(grammatical/0, np_proper_at/1).
determination(grammatical/0, np_quant_at/1).
determination(grammatical/0, vp_intrans_at/1).
determination(grammatical/0, vp_trans_at/1).


% FOLDS

fold(train, [1,3,5,7,9,11,13,15,17,19,21,23,25,27,29,31,33,35,37,39,
             41,43,45,47,49,51,53,55,57,59,61,63,65,67,69,71,73,75,77,79,
             81,83,85,87,89,91,93,95,97,99,101,103,105,107,109,111,113,115,117,119,121,123,125,127,129,131,133,135,137,139,141]).

fold(test,  [2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,
             42,44,46,48,50,52,54,56,58,60,62,64,66,68,70,72,74,76,78,80,82,
             84,86,88,90,92,94,96,98,100,102,104,106,108,110,112,114,116,118,120,122,124,126,128,130,132,134,136,138,140]).


% MODELS 
% POSITIVE EXAMPLES
begin(model(1)).
grammatical.
s_has_term(1, 1, john, 0).
s_has_term(1, 2, paints, 1).
end(model(1)).

begin(model(2)).
grammatical.
s_has_term(2, 1, annie, 0).
s_has_term(2, 2, paints, 1).
end(model(2)).

begin(model(3)).
grammatical.
s_has_term(3, 1, monet, 0).
s_has_term(3, 2, paints, 1).
end(model(3)).

begin(model(4)).
grammatical.
s_has_term(4, 1, a, 0).
s_has_term(4, 2, man, 1).
s_has_term(4, 3, paints, 2).
end(model(4)).

begin(model(5)).
grammatical.
s_has_term(5, 1, a, 0).
s_has_term(5, 2, woman, 1).
s_has_term(5, 3, paints, 2).
end(model(5)).

begin(model(6)).
grammatical.
s_has_term(6, 1, every, 0).
s_has_term(6, 2, man, 1).
s_has_term(6, 3, paints, 2).
end(model(6)).

begin(model(7)).
grammatical.
s_has_term(7, 1, every, 0).
s_has_term(7, 2, woman, 1).
s_has_term(7, 3, paints, 2).
end(model(7)).

begin(model(8)).
grammatical.
s_has_term(8, 1, john, 0).
s_has_term(8, 2, likes, 1).
s_has_term(8, 3, annie, 2).
end(model(8)).

begin(model(9)).
grammatical.
s_has_term(9, 1, john, 0).
s_has_term(9, 2, admires, 1).
s_has_term(9, 3, annie, 2).
end(model(9)).

begin(model(10)).
grammatical.
s_has_term(10, 1, john, 0).
s_has_term(10, 2, likes, 1).
s_has_term(10, 3, monet, 2).
end(model(10)).

begin(model(11)).
grammatical.
s_has_term(11, 1, annie, 0).
s_has_term(11, 2, admires, 1).
s_has_term(11, 3, john, 2).
end(model(11)).

begin(model(12)).
grammatical.
s_has_term(12, 1, annie, 0).
s_has_term(12, 2, likes, 1).
s_has_term(12, 3, monet, 2).
end(model(12)).

begin(model(13)).
grammatical.
s_has_term(13, 1, monet, 0).
s_has_term(13, 2, likes, 1).
s_has_term(13, 3, john, 2).
end(model(13)).

begin(model(14)).
grammatical.
s_has_term(14, 1, monet, 0).
s_has_term(14, 2, admires, 1).
s_has_term(14, 3, annie, 2).
end(model(14)).

begin(model(15)).
grammatical.
s_has_term(15, 1, a, 0).
s_has_term(15, 2, man, 1).
s_has_term(15, 3, likes, 2).
s_has_term(15, 4, annie, 3).
end(model(15)).

begin(model(16)).
grammatical.
s_has_term(16, 1, a, 0).
s_has_term(16, 2, woman, 1).
s_has_term(16, 3, admires, 2).
s_has_term(16, 4, john, 3).
end(model(16)).

begin(model(17)).
grammatical.
s_has_term(17, 1, every, 0).
s_has_term(17, 2, man, 1).
s_has_term(17, 3, likes, 2).
s_has_term(17, 4, annie, 3).
end(model(17)).

begin(model(18)).
grammatical.
s_has_term(18, 1, every, 0).
s_has_term(18, 2, woman, 1).
s_has_term(18, 3, admires, 2).
s_has_term(18, 4, monet, 3).
end(model(18)).

begin(model(19)).
grammatical.
s_has_term(19, 1, john, 0).
s_has_term(19, 2, paints, 1).
s_has_term(19, 3, that, 2).
s_has_term(19, 4, annie, 3).
s_has_term(19, 5, paints, 4).
end(model(19)).

begin(model(20)).
grammatical.
s_has_term(20, 1, a, 0).
s_has_term(20, 2, man, 1).
s_has_term(20, 3, paints, 2).
s_has_term(20, 4, that, 3).
s_has_term(20, 5, annie, 4).
s_has_term(20, 6, likes, 5).
end(model(20)).

begin(model(21)).
grammatical.
s_has_term(21, 1, every, 0).
s_has_term(21, 2, man, 1).
s_has_term(21, 3, paints, 2).
s_has_term(21, 4, that, 3).
s_has_term(21, 5, a, 4).
s_has_term(21, 6, woman, 5).
s_has_term(21, 7, admires, 6).
end(model(21)).

begin(model(22)).
grammatical.
s_has_term(22, 1, john, 0).
s_has_term(22, 2, likes, 1).
s_has_term(22, 3, annie, 2).
end(model(22)).

begin(model(23)).
grammatical.
s_has_term(23, 1, annie, 0).
s_has_term(23, 2, paints, 1).
end(model(23)).

begin(model(24)).
grammatical.
s_has_term(24, 1, a, 0).
s_has_term(24, 2, woman, 1).
s_has_term(24, 3, likes, 2).
s_has_term(24, 4, john, 3).
end(model(24)).

begin(model(25)).
grammatical.
s_has_term(25, 1, every, 0).
s_has_term(25, 2, man, 1).
s_has_term(25, 3, admires, 2).
s_has_term(25, 4, monet, 3).
end(model(25)).

begin(model(26)).
grammatical.
s_has_term(26, 1, monet, 0).
s_has_term(26, 2, paints, 1).
end(model(26)).

begin(model(27)).
grammatical.
s_has_term(27, 1, a, 0).
s_has_term(27, 2, man, 1).
s_has_term(27, 3, likes, 2).
s_has_term(27, 4, monet, 3).
end(model(27)).

begin(model(28)).
grammatical.
s_has_term(28, 1, every, 0).
s_has_term(28, 2, woman, 1).
s_has_term(28, 3, paints, 2).
end(model(28)).

begin(model(29)).
grammatical.
s_has_term(29, 1, john, 0).
s_has_term(29, 2, admires, 1).
s_has_term(29, 3, monet, 2).
end(model(29)).

begin(model(30)).
grammatical.
s_has_term(30, 1, a, 0).
s_has_term(30, 2, woman, 1).
s_has_term(30, 3, paints, 2).
end(model(30)).

begin(model(31)).
grammatical.
s_has_term(31, 1, annie, 0).
s_has_term(31, 2, likes, 1).
s_has_term(31, 3, john, 2).
end(model(31)).

begin(model(32)).
grammatical.
s_has_term(32, 1, a, 0).
s_has_term(32, 2, man, 1).
s_has_term(32, 3, admires, 2).
s_has_term(32, 4, annie, 3).
end(model(32)).

begin(model(33)).
grammatical.
s_has_term(33, 1, every, 0).
s_has_term(33, 2, woman, 1).
s_has_term(33, 3, likes, 2).
s_has_term(33, 4, monet, 3).
end(model(33)).

begin(model(34)).
grammatical.
s_has_term(34, 1, monet, 0).
s_has_term(34, 2, admires, 1).
s_has_term(34, 3, john, 2).
end(model(34)).

begin(model(35)).
grammatical.
s_has_term(35, 1, a, 0).
s_has_term(35, 2, woman, 1).
s_has_term(35, 3, admires, 2).
s_has_term(35, 4, annie, 3).
end(model(35)).

begin(model(36)).
grammatical.
s_has_term(36, 1, every, 0).
s_has_term(36, 2, man, 1).
s_has_term(36, 3, likes, 2).
s_has_term(36, 4, monet, 3).
end(model(36)).

begin(model(37)).
grammatical.
s_has_term(37, 1, john, 0).
s_has_term(37, 2, likes, 1).
s_has_term(37, 3, monet, 2).
end(model(37)).

begin(model(38)).
grammatical.
s_has_term(38, 1, annie, 0).
s_has_term(38, 2, admires, 1).
s_has_term(38, 3, monet, 2).
end(model(38)).

begin(model(39)).
grammatical.
s_has_term(39, 1, a, 0).
s_has_term(39, 2, man, 1).
s_has_term(39, 3, paints, 2).
end(model(39)).

begin(model(40)).
grammatical.
s_has_term(40, 1, every, 0).
s_has_term(40, 2, woman, 1).
s_has_term(40, 3, admires, 2).
s_has_term(40, 4, john, 3).
end(model(40)).

% NEGATIVE EXAMPLES
begin(model(41)).
neg(grammatical).
s_has_term(41, 1, paints, 0).
s_has_term(41, 2, john, 1).
end(model(41)).

begin(model(42)).
neg(grammatical).
s_has_term(42, 1, paints, 0).
s_has_term(42, 2, annie, 1).
end(model(42)).

begin(model(43)).
neg(grammatical).
s_has_term(43, 1, paints, 0).
s_has_term(43, 2, monet, 1).
end(model(43)).

begin(model(44)).
neg(grammatical).
s_has_term(44, 1, man, 0).
s_has_term(44, 2, a, 1).
s_has_term(44, 3, paints, 2).
end(model(44)).

begin(model(45)).
neg(grammatical).
s_has_term(45, 1, woman, 0).
s_has_term(45, 2, a, 1).
s_has_term(45, 3, paints, 2).
end(model(45)).

begin(model(46)).
neg(grammatical).
s_has_term(46, 1, man, 0).
s_has_term(46, 2, every, 1).
s_has_term(46, 3, paints, 2).
end(model(46)).

begin(model(47)).
neg(grammatical).
s_has_term(47, 1, woman, 0).
s_has_term(47, 2, every, 1).
s_has_term(47, 3, paints, 2).
end(model(47)).

begin(model(48)).
neg(grammatical).
s_has_term(48, 1, likes, 0).
s_has_term(48, 2, john, 1).
s_has_term(48, 3, annie, 2).
end(model(48)).

begin(model(49)).
neg(grammatical).
s_has_term(49, 1, admires, 0).
s_has_term(49, 2, john, 1).
s_has_term(49, 3, annie, 2).
end(model(49)).

begin(model(50)).
neg(grammatical).
s_has_term(50, 1, john, 0).
s_has_term(50, 2, likes, 1).
s_has_term(50, 3, annie, 2).
s_has_term(50, 4, paints, 3).
end(model(50)).

begin(model(51)).
neg(grammatical).
s_has_term(51, 1, annie, 0).
s_has_term(51, 2, admires, 1).
s_has_term(51, 3, john, 2).
s_has_term(51, 4, paints, 3).
end(model(51)).

begin(model(52)).
neg(grammatical).
s_has_term(52, 1, annie, 0).
s_has_term(52, 2, likes, 1).
s_has_term(52, 3, monet, 2).
s_has_term(52, 4, paints, 3).
end(model(52)).

begin(model(53)).
neg(grammatical).
s_has_term(53, 1, monet, 0).
s_has_term(53, 2, likes, 1).
s_has_term(53, 3, john, 2).
s_has_term(53, 4, paints, 3).
end(model(53)).

begin(model(54)).
neg(grammatical).
s_has_term(54, 1, monet, 0).
s_has_term(54, 2, admires, 1).
s_has_term(54, 3, annie, 2).
s_has_term(54, 4, paints, 3).
end(model(54)).

begin(model(55)).
neg(grammatical).
s_has_term(55, 1, man, 0).
s_has_term(55, 2, a, 1).
s_has_term(55, 3, likes, 2).
s_has_term(55, 4, annie, 3).
end(model(55)).

begin(model(56)).
neg(grammatical).
s_has_term(56, 1, woman, 0).
s_has_term(56, 2, a, 1).
s_has_term(56, 3, admires, 2).
s_has_term(56, 4, john, 3).
end(model(56)).

begin(model(57)).
neg(grammatical).
s_has_term(57, 1, man, 0).
s_has_term(57, 2, every, 1).
s_has_term(57, 3, likes, 2).
s_has_term(57, 4, annie, 3).
end(model(57)).

begin(model(58)).
neg(grammatical).
s_has_term(58, 1, woman, 0).
s_has_term(58, 2, every, 1).
s_has_term(58, 3, admires, 2).
s_has_term(58, 4, monet, 3).
end(model(58)).

begin(model(59)).
neg(grammatical).
s_has_term(59, 1, likes, 0).
s_has_term(59, 2, john, 1).
s_has_term(59, 3, that, 2).
s_has_term(59, 4, annie, 3).
s_has_term(59, 5, paints, 4).
end(model(59)).

begin(model(60)).
neg(grammatical).
s_has_term(60, 1, man, 0).
s_has_term(60, 2, a, 1).
s_has_term(60, 3, likes, 2).
s_has_term(60, 4, that, 3).
s_has_term(60, 5, annie, 4).
s_has_term(60, 6, likes, 5).
end(model(60)).

begin(model(61)).
neg(grammatical).
s_has_term(61, 1, man, 0).
s_has_term(61, 2, every, 1).
s_has_term(61, 3, likes, 2).
s_has_term(61, 4, that, 3).
s_has_term(61, 5, a, 4).
s_has_term(61, 6, woman, 5).
s_has_term(61, 7, admires, 6).
end(model(61)).

begin(model(62)).
neg(grammatical).
s_has_term(62, 1, likes, 0).
s_has_term(62, 2, john, 1).
s_has_term(62, 3, annie, 2).
end(model(62)).

begin(model(63)).
neg(grammatical).
s_has_term(63, 1, likes, 0).
s_has_term(63, 2, annie, 1).
end(model(63)).

begin(model(64)).
neg(grammatical).
s_has_term(64, 1, woman, 0).
s_has_term(64, 2, a, 1).
s_has_term(64, 3, likes, 2).
s_has_term(64, 4, john, 3).
end(model(64)).

begin(model(65)).
neg(grammatical).
s_has_term(65, 1, man, 0).
s_has_term(65, 2, every, 1).
s_has_term(65, 3, admires, 2).
s_has_term(65, 4, monet, 3).
end(model(65)).

begin(model(66)).
neg(grammatical).
s_has_term(66, 1, likes, 0).
s_has_term(66, 2, monet, 1).
end(model(66)).

begin(model(67)).
neg(grammatical).
s_has_term(67, 1, woman, 0).
s_has_term(67, 2, a, 1).
s_has_term(67, 3, likes, 2).
s_has_term(67, 4, monet, 3).
end(model(67)).

begin(model(68)).
neg(grammatical).
s_has_term(68, 1, woman, 0).
s_has_term(68, 2, every, 1).
s_has_term(68, 3, paints, 2).
end(model(68)).

begin(model(69)).
neg(grammatical).
s_has_term(69, 1, likes, 0).
s_has_term(69, 2, john, 1).
s_has_term(69, 3, monet, 2).
end(model(69)).

begin(model(70)).
neg(grammatical).
s_has_term(70, 1, woman, 0).
s_has_term(70, 2, a, 1).
s_has_term(70, 3, paints, 2).
end(model(70)).

begin(model(71)).
neg(grammatical).
s_has_term(71, 1, likes, 0).
s_has_term(71, 2, annie, 1).
s_has_term(71, 3, john, 2).
end(model(71)).

begin(model(72)).
neg(grammatical).
s_has_term(72, 1, man, 0).
s_has_term(72, 2, a, 1).
s_has_term(72, 3, admires, 2).
s_has_term(72, 4, annie, 3).
end(model(72)).

begin(model(73)).
neg(grammatical).
s_has_term(73, 1, woman, 0).
s_has_term(73, 2, every, 1).
s_has_term(73, 3, likes, 2).
s_has_term(73, 4, monet, 3).
end(model(73)).

begin(model(74)).
neg(grammatical).
s_has_term(74, 1, likes, 0).
s_has_term(74, 2, monet, 1).
s_has_term(74, 3, john, 2).
end(model(74)).

begin(model(75)).
neg(grammatical).
s_has_term(75, 1, woman, 0).
s_has_term(75, 2, a, 1).
s_has_term(75, 3, admires, 2).
s_has_term(75, 4, annie, 3).
end(model(75)).

begin(model(76)).
neg(grammatical).
s_has_term(76, 1, man, 0).
s_has_term(76, 2, every, 1).
s_has_term(76, 3, likes, 2).
s_has_term(76, 4, monet, 3).
end(model(76)).

begin(model(77)).
neg(grammatical).
s_has_term(77, 1, likes, 0).
s_has_term(77, 2, john, 1).
s_has_term(77, 3, monet, 2).
end(model(77)).

begin(model(78)).
neg(grammatical).
s_has_term(78, 1, admires, 0).
s_has_term(78, 2, annie, 1).
s_has_term(78, 3, monet, 2).
end(model(78)).

begin(model(79)).
neg(grammatical).
s_has_term(79, 1, woman, 0).
s_has_term(79, 2, a, 1).
s_has_term(79, 3, paints, 2).
end(model(79)).

begin(model(80)).
neg(grammatical).
s_has_term(80, 1, woman, 0).
s_has_term(80, 2, every, 1).
s_has_term(80, 3, admires, 2).
s_has_term(80, 4, john, 3).
end(model(80)).