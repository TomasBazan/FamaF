#include <stdio.h>
#include <stdlib.h>
#include "array_helpers.h"
#include "weather_utils.h"

int minTempHis(WeatherTable array)
{
    int minTemp = array[0][0][0]._max_temp;
    for (unsigned int year = 0u; year < YEARS; year++)
    {
        for (unsigned int month = january; month <= december; month++)
        {
            for (unsigned int day = 0u; day < DAYS; day++)
            {
                if (minTemp > array[year][month][day]._min_temp)
                {
                    minTemp = array[year][month][day]._min_temp;
                }
            }
        }
    }
    return minTemp;
}

void maxTempAnio(WeatherTable array, int temperaturas[])
{
    int maxTemp;
    for (unsigned int year = 0u; year < YEARS; year++)
    {
        for (unsigned int month = january; month <= december; month++)
        {
            for (unsigned int day = 0u; day < DAYS; day++)
            {
                if (maxTemp < array[year][month][day]._max_temp)
                {
                    maxTemp = array[year][month][day]._max_temp;
                }
            }
            temperaturas[year] = maxTemp;
        }
    }
    for (int i = 0u; i < YEARS; ++i)
    {
        fprintf(stdout, "La mayor temperatura del año %d es %d \n", i + 1980, temperaturas[i]);
    }
}

void maxCantPrec(WeatherTable array, int mesMaxPrec[])
{

    for (unsigned int year = 0u; year < YEARS; year++)
    {
        unsigned int cantMayorMes = 0;
        unsigned int mayorMes;
        for (unsigned int month = january; month <= december; month++)
        {
            unsigned int acumPrec = 0;

            for (unsigned int day = 0u; day < DAYS; day++)
            {
                acumPrec += array[year][month][day]._rainfall;
            }
            if (cantMayorMes < acumPrec)
            {
                cantMayorMes = acumPrec;
                mayorMes = month + 1;
            }
            mesMaxPrec[year] = mayorMes;
        }
    }
    for (int i = 0u; i < YEARS; ++i)
    {
        fprintf(stdout, "El mes de mayor precipitaciones del año %d es %d \n", i + 1980, mesMaxPrec[i]);
    }
}