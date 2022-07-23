/*
  @file sort.h
  @brief Sort functions declarations
*/
#ifndef _SORT_H
#define _SORT_H
#include <stdbool.h>
#include "player.h"

/**
 * @brief Returns true if player 'x' goes before player 'y' in a sorted array of players.
 *
 * @param[in]  x Player 'x'
 * @param[in]  y Player 'y'
 *
 * @return true if player 'x' goes before player 'y' in a sorted array of players.
 */
bool goes_before(player_t x, player_t y);

/**
 * @brief    Checks if the array 'a' is in ascending order according
 *           to the goes_before function
 *
 * @param[in]  atp     The Player array
 * @param[in]  length  Length of player array
 *
 * @return True if array is sorted in ascendirng order according to goes_before function, false otherwise
 */
bool array_is_sorted(player_t atp[], unsigned int length);

/**
 * @brief Sort the array 'a' using any sorting algorithm. The resulting sort
 *        will be ascending according to the goes_before funtion.
 *        The array 'a' must have exactly 'length' elements.
 *
 * @param[in]      a       Players array
 * @param[in]      length  Length of players array
 */
void sort(player_t a[], unsigned int length);

/**
 * @brief  Exchanges elements of array 'a' in the given positions 'i' and 'j'
 *         Array remains the same if the two positions are the same
 *
 * @param[in]        a    Players array
 * @param[in]        i    Firs element to swap
 * @param[in]        j    Second element to swap
 */

void swap(player_t a[], unsigned int i, unsigned int j);

/**
 * @brief Compares all the elements of the array whit 'i'. If any is smaller, it swap it
 *
 * 
 * @param[in]       a Array of players
 * @param[in]       i indicates the position up to which the array is sorted
 */
void insert(player_t a[], unsigned int i);

/**
 * @brief Create a of i and change the original for j, after that change j for the copy of the original i
 * 
 * @param[in]        a Array of players
 * @param[in]        i First position of the elements to swap
 * @param[in]        j Second position of the elements to swap
 */
void swap(player_t a[], unsigned int i, unsigned int j);
#endif
