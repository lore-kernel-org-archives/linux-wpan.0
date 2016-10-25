Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:39128
        "EHLO s-opensource.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755630AbcJYPyh (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 25 Oct 2016 11:54:37 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: Re: [PATCH 3/3] ieee802154: Add entry in MAINTAINTERS for CA8210
 driver
References: <20161024150449.11132-1-h.morris@cascoda.com>
 <20161024150449.11132-4-h.morris@cascoda.com>
Message-ID: <6468d7d1-6c0d-5390-3502-ebd917c5999d@osg.samsung.com>
Date: Tue, 25 Oct 2016 17:54:30 +0200
MIME-Version: 1.0
In-Reply-To: <20161024150449.11132-4-h.morris@cascoda.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: harrymorris12@gmail.com, linux-wpan@vger.kernel.org
Cc: alex.aring@gmail.com, Harry Morris <h.morris@cascoda.com>

Hello.

On 24/10/16 17:04, harrymorris12@gmail.com wrote:
> From: Harry Morris <h.morris@cascoda.com>
>
> Signed-off-by: Harry Morris <h.morris@cascoda.com>
> ---
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 05e5450..37df5b0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2130,6 +2130,15 @@ W:	http://www.linux-c6x.org/wiki/index.php/Main_Page
>  S:	Maintained
>  F:	arch/c6x/
>
> +CA8210 IEEE-802.15.4 RADIO DRIVER
> +M:	Harry Morris <h.morris@cascoda.com>
> +M:	linuxdev@cascoda.com
> +L:	linux-wpan@vger.kernel.org
> +W:	https://github.com/Cascoda/ca8210-linux.git
> +S:	Maintained
> +F:	drivers/net/ieee802154/ca8210.c
> +F:	Documentation/devicetree/bindings/net/ieee802154/ca8210.txt
> +
>  CACHEFILES: FS-CACHE BACKEND FOR CACHING ON MOUNTED FILESYSTEMS
>  M:	David Howells <dhowells@redhat.com>
>  L:	linux-cachefs@redhat.com
>

Looks good to me. You can add my:

Acked-by: Stefan Schmidt <stefan@osg.samsung.com>

regards
Stefan Schmidt
