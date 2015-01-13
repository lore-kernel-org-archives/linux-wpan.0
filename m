Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mailgw1.uni-kl.de ([131.246.120.220]:57120 "EHLO
	mailgw1.uni-kl.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751744AbbAMMqr (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 13 Jan 2015 07:46:47 -0500
Date: Tue, 13 Jan 2015 13:33:39 +0100
From: Phoebe Buckheister <phoebe.buckheister@itwm.fraunhofer.de>
Subject: Re: [RFC bluetooth-next 1/2] af_ieee802154: fix struct
 ieee802154_addr_sa size
Message-ID: <20150113133339.0272b42f@zoidberg>
In-Reply-To: <1420929206-5771-2-git-send-email-alex.aring@gmail.com>
References: <1420929206-5771-1-git-send-email-alex.aring@gmail.com>
	<1420929206-5771-2-git-send-email-alex.aring@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, kernel@pengutronix.de, marcel@holtmann.org, werner@almesberger.net, mkl@pengutronix.de

Hi,

On Sat, 10 Jan 2015 23:33:25 +0100
Alexander Aring <alex.aring@gmail.com> wrote:

> The structure "ieee802154_addr_sa" need to fit into the u8 sa_data[14]
> from struct sockaddr, because there is a casting of "struct sockaddr"
> and "struct ieee802154_sockaddr".
> 
> I tested a compiling with a 32 bit system and detected that the
> "struct ieee802154_sockaddr", which contains the ieee802154_addr_sa
> structure, has a size of 20 bytes. The "struct sockaddr" has a size
> of 16 bytes. This doesn't fit together and some buffers are
> overflows. This patch changes the "addr_type" type definition from
> "int" to "u8". After this change it will be fits together.

Do look at how Unix domain sockets handle the problem. Also, IPv6
addresses exceed sizeof(struct sockaddr) quite significantly. Casting
pointers isn't a problem, only if we *ever* store our addrs to a struct
sockaddr will we have a problem.

Perhaps I am missing something, but from what I can tell, i think the
code is safe at least in that regard.

> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
>  include/net/af_ieee802154.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/net/af_ieee802154.h b/include/net/af_ieee802154.h
> index 7d38e2f..3652269 100644
> --- a/include/net/af_ieee802154.h
> +++ b/include/net/af_ieee802154.h
> @@ -33,7 +33,7 @@ enum {
>  #define IEEE802154_ADDR_LEN	8
>  
>  struct ieee802154_addr_sa {
> -	int addr_type;
> +	u8 addr_type;
>  	u16 pan_id;
>  	union {
>  		u8 hwaddr[IEEE802154_ADDR_LEN];

