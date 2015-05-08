Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:50091 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751493AbbEHIJJ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 8 May 2015 04:09:09 -0400
Message-ID: <554C6F1A.5080408@xsilon.com>
Date: Fri, 08 May 2015 09:08:58 +0100
From: Martin Townsend <martin.townsend@xsilon.com>
MIME-Version: 1.0
Subject: Re: [PATCHv2 wpan-tools] interface: use hexadecimal for print extended
 addr
References: <1431001593-30128-1-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1431001593-30128-1-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, =?UTF-8?B?R3VpZG8gR8O8bnRoZXI=?= <agx@sigxcpu.org>

Tested-by: Martin Townsend <martin.townsend@xsilon.com>

iwpan dev
phy#2
        Interface wpan2
                ifindex 12
                wpan_dev 0x200000002
                extended_addr 0x00039a000002012c
                short_addr 0xffff
                pan_id 0xffff
                type node
                max_frame_retries 4
                min_be 4
                max_be 9
                max_csma_backoffs 8
                lbt 0
phy#1
        Interface wpan1
                ifindex 9
                wpan_dev 0x100000002
                extended_addr 0x00039a000001012c
                short_addr 0x012c
                pan_id 0x0700
                type node
                max_frame_retries 4
                min_be 4
                max_be 9
                max_csma_backoffs 8
                lbt 0
phy#0
        Interface wpan0
                ifindex 6
                wpan_dev 0x2
                extended_addr 0x00039a000000012c
                short_addr 0x012c
                pan_id 0x0777
                type node
                max_frame_retries 4
                min_be 4
                max_be 9
                max_csma_backoffs 8
                lbt 0


On 07/05/15 13:26, Alexander Aring wrote:
> This patch prints the extended addr in hexadecimal value. This is what
> the "0x...." prefix suggested.
>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> Cc: Guido Günther <agx@sigxcpu.org>
> ---
> changes since v2:
>  - s/inteface/interface/
>  - can't remove the v we are already at v2
>
>  src/interface.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/src/interface.c b/src/interface.c
> index 5e0ef89..e501763 100644
> --- a/src/interface.c
> +++ b/src/interface.c
> @@ -203,7 +203,7 @@ static int print_iface_handler(struct nl_msg *msg, void *arg)
>  		printf("%s\twpan_dev 0x%llx\n", indent,
>  		       (unsigned long long)nla_get_u64(tb_msg[NL802154_ATTR_WPAN_DEV]));
>  	if (tb_msg[NL802154_ATTR_EXTENDED_ADDR])
> -		printf("%s\textended_addr 0x%016" PRIu64 "\n", indent,
> +		printf("%s\textended_addr 0x%016" PRIx64 "\n", indent,
>  		       le64toh(nla_get_u64(tb_msg[NL802154_ATTR_EXTENDED_ADDR])));
>  	if (tb_msg[NL802154_ATTR_SHORT_ADDR])
>  		printf("%s\tshort_addr 0x%04x\n", indent,

