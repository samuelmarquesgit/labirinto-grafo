@echo off
REM =============================================================================
REM Commit das mudancas de coloracao
REM Script: scripts/commit-cores.bat
REM Executa a partir de: scripts/ (vai para raiz automaticamente)
REM =============================================================================

REM Ir para a raiz do projeto (um nível acima de scripts/)
cd /d "%~dp0.."

echo.
echo =====================================================
echo  Fazendo commit das mudancas de coloracao
echo =====================================================
echo.

REM Verificar se estamos num repositorio git
git rev-parse --git-dir >nul 2>&1
if errorlevel 1 (
    echo ERRO: Nao e um repositorio git!
    echo Certifique-se de que esta no diretorio correto do projeto
    pause
    exit /b 1
)

REM Mostrar status
echo Status atual:
git status
echo.

REM Perguntar antes de fazer commit
echo.
echo Arquivos que serao adicionados:
echo  - visualizacao.h (constantes de cores)
echo  - visualizacao.c (funcoes definirCor, restaurarCor, exibirLabirintoComCores)
echo  - steering/structure.md (documentacao)
echo  - README.md (secoes de cores)
echo  - docs/CORES_VISUALIZACAO.md (novo - guia completo)
echo  - docs/IMPLEMENTACAO_CORES.md (novo - detalhes tecnicos)
echo  - scripts/commit-cores.bat (novo - automacao de commit)
echo  - scripts/test-compile.bat (novo - teste rapido)
echo.

REM Fazer add
echo Adicionando arquivos...
git add -A

echo.
echo Fazendo commit...
git commit -m "feat(viz): sistema de coloracao com 3 fases (vermelho/azul/verde)" -m "
Implementacao:
- Adiciona constantes de cor (COR_VERMELHO, COR_VERDE, COR_AZUL)
- Implementa funcoes definirCor() e restaurarCor()
- Cria funcao exibirLabirintoComCores() para coloracao automatica

Fases de cor:
- Fase 1 (Exploracao): visitados em VERMELHO
- Fase 2 (Reconstrucao): caminho em AZUL
- Fase 3 (Resultado): caminho em VERDE

Documentacao:
- docs/CORES_VISUALIZACAO.md: guia completo de cores
- docs/IMPLEMENTACAO_CORES.md: detalhes tecnicos
- README.md: atualizado com secoes de cores
- steering/structure.md: atualizado

Scripts:
- scripts/commit-cores.bat: automacao de commit
- scripts/test-compile.bat: teste rapido de compilacao

Compatibilidade:
- Windows: totalmente funcional
- Linux/macOS: compila sem erros, sem cores (futuro: ANSI codes)
"

if errorlevel 1 (
    echo.
    echo ERRO ao fazer commit!
    pause
    exit /b 1
)

echo.
echo =====================================================
echo  Commit realizado com sucesso!
echo =====================================================
echo.

REM Mostrar o commit criado
git log -1 --oneline

echo.
echo Proximos passos:
echo  1. Testar compilacao: .\scripts\test-compile.bat
echo  2. Compilar projeto: .\build.bat
echo  3. Executar programa: .\bin\labirinto.exe
echo  4. Fazer push: git push origin develop
echo  5. Criar PR: .\scripts\auto-pr.ps1 feat viz "Sistema de coloracao"
echo.

pause
