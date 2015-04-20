Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:34143 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753128AbbDTQFL (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 20 Apr 2015 12:05:11 -0400
Received: by wicmx19 with SMTP id mx19so43609825wic.1
        for <linux-wpan@vger.kernel.org>; Mon, 20 Apr 2015 09:05:10 -0700 (PDT)
Date: Mon, 20 Apr 2015 18:05:07 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [wpan-tools] Use PRIu64 for formatting uint64_t
Message-ID: <20150420160505.GB707@omega>
References: <20150419160033.GA7869@bogon.m.sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20150419160033.GA7869@bogon.m.sigxcpu.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>
Cc: linux-wpan@vger.kernel.org

Hi Guido,

On Sun, Apr 19, 2015 at 06:00:33PM +0200, Guido Günther wrote:
> This fixes:
> 
> CC       iwpan-interface.o
> interface.c: In function ‘print_iface_handler’:
> interface.c:206:10: warning: format ‘%llx’ expects argument of type ‘long long unsigned int’, but argument 3 has type ‘uint64_t’ [-Wformat=]
>           le64toh(nla_get_u64(tb_msg[NL802154_ATTR_EXTENDED_ADDR])));
>           ^

thanks, applied.

- Alex
