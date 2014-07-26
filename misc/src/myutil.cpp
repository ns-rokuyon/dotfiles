#include "myutil.h"

bool CmdlineParser::exists(const std::string& opt, const int argc, char** argv){
    return std::find(argv, argv + argc, opt) != argv + argc;
}

char* CmdlineParser::getOptArg(const std::string& opt, const int argc, char** argv){
    char** it = std::find(argv, argv + argc, opt);
    if (it != argv + argc && ++it != argv + argc) {
        return *it;
    }
    return NULL;
}
