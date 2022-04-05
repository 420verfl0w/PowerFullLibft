/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   libft.h                                            :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: brda-sil <brda-sil@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2022/02/22 13:16:35 by stales            #+#    #+#             */
/*   Updated: 2022/04/05 21:17:40 by brda-sil         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef LIBFT_H
# define LIBFT_H
# define LIBFT_NULL (void *)0

typedef unsigned char		t_uint8;
typedef unsigned int		t_uint32;
typedef unsigned long		t_size;
typedef long long			t_int64;

/////////////////////////////////////
//
//	FUNCTION STRINGS
//
/////////////////////////////////////
/**
 * @brief			Converts the initial portion of the string pointed to by str
 *					to int.
 *
 * @param nptr		String to convert
 *
 * @return (int)	The converted value or 0 on error
 */
int				ft_atoi(const char *nptr);

#endif
