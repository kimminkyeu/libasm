char * strcpy(char * dst, const char * src)
{
    char * dst_start = dst;
    while (*(src))
        *(dst++) = *(src++);
    return dst_start;
}