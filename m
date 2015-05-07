Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:33784 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751234AbbEGMRJ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 7 May 2015 08:17:09 -0400
Received: by pdbnk13 with SMTP id nk13so39977129pdb.0
        for <linux-wpan@vger.kernel.org>; Thu, 07 May 2015 05:17:09 -0700 (PDT)
Message-ID: <554B57AD.9000700@gmail.com>
Date: Thu, 07 May 2015 17:46:45 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCHv wpan-tools] inteface: use hexadecimal for print extended
 addr
References: <1430999561-28790-1-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1430999561-28790-1-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, =?UTF-8?B?R3VpZG8gR8O8bnRoZXI=?= <agx@sigxcpu.org>

s/inteface/interface and also remove 'v' after PATCH 

On 05/07/2015 05:22 PM, Alexander Aring wrote:

> This patch prints the extended addr in hexadecimal value. This is what
> the "0x...." prefix suggested.
>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> Cc: Guido Günther <agx@sigxcpu.org>
> ---
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

-- 
Varka Bhadram

