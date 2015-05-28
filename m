Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mailgw1.uni-kl.de ([131.246.120.220]:57301 "EHLO
	mailgw1.uni-kl.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751387AbbE1PNS (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 28 May 2015 11:13:18 -0400
Received: from itwm2.itwm.fhg.de (itwm2.itwm.fhg.de [131.246.191.3])
	by mailgw1.uni-kl.de (8.14.4/8.14.4/Debian-7) with ESMTP id t4SFDGhX012376
	for <linux-wpan@vger.kernel.org>; Thu, 28 May 2015 17:13:16 +0200
Date: Thu, 28 May 2015 17:13:15 +0200
From: Phoebe Buckheister <phoebe.buckheister@itwm.fraunhofer.de>
Subject: Re: [PATCH,RFC bluetooth-next 1/2] ieee802154: Fix generation of
 random EUI-64 addresses.
Message-ID: <20150528171315.0833a387@zoidberg>
In-Reply-To: <20150528123832.GD11340@wantstofly.org>
References: <20150528123832.GD11340@wantstofly.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: linux-wpan@vger.kernel.org

On Thu, 28 May 2015 15:38:32 +0300
Lennert Buytenhek <buytenh@wantstofly.org> wrote:

> Currently, ieee802154_random_extended_addr() has a 50% chance of
> generating a group (multicast) address, while this function is used
> for generating station addresses (which can't be group addresses)
> for interfaces that don't have a hardware-provided address.
> 
> Also, in case get_random_bytes() generates the EUI-64 address
> 00:00:00:00:00:00:00:00 (extremely unlikely), which is an invalid
> address, ieee802154_random_extended_addr() reacts by changing it
> to 01:00:00:00:00:00:00:00, which is an invalid station address as
> well, as it is a group address.
> 
> This patch changes the address generation procedure to grab eight
> random bytes, treat that as an EUI-64, and then clear the Group
> address bit and set the Locally Administered bit, which is in
> line with how eth_random_addr() generates random EUI-48s.

Looks good to me. Even if this ends up being uneccessarily strict, we'll
always have a huge pool of addresses we may generate.
Note: the standard only says that the address shall be a 64 bit
universal address (not excluding multicast), but not generating
multicast EUIs seems like a good idea anyway.
 
> Signed-off-by: Lennert Buytenhek <buytenh@wantstofly.org>
> ---
>  include/linux/ieee802154.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/ieee802154.h b/include/linux/ieee802154.h
> index 8872ca1..552210d 100644
> --- a/include/linux/ieee802154.h
> +++ b/include/linux/ieee802154.h
> @@ -244,9 +244,9 @@ static inline void
> ieee802154_random_extended_addr(__le64 *addr) {
>  	get_random_bytes(addr, IEEE802154_EXTENDED_ADDR_LEN);
>  
> -	/* toggle some bit if we hit an invalid extended addr */
> -	if (!ieee802154_is_valid_extended_addr(*addr))
> -		((u8 *)addr)[IEEE802154_EXTENDED_ADDR_LEN - 1] ^=
> 0x01;
> +	/* clear the group bit, and set the locally administered bit
> */
> +	((u8 *)addr)[IEEE802154_EXTENDED_ADDR_LEN - 1] &= ~0x01;
> +	((u8 *)addr)[IEEE802154_EXTENDED_ADDR_LEN - 1] |= 0x02;
>  }
>  
>  #endif /* LINUX_IEEE802154_H */

