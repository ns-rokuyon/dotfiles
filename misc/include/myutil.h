#include <iostream>
#include <algorithm>

class CmdlineParser{
    public:
        static bool exists(const std::string& opt, const int argc, char** argv);
        static char* getOptArg(const std::string& opt, const int argc, char** argv);
};
