Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:33964 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751548AbaJAKV1 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 1 Oct 2014 06:21:27 -0400
Date: Wed, 1 Oct 2014 12:21:20 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH] trivial: net/mac802154: Fix Kconfig typo
Message-ID: <20141001102118.GA25269@omega>
References: <1412158018-8707-1-git-send-email-julien.catalano@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1412158018-8707-1-git-send-email-julien.catalano@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Julien Catalano <julien.catalano@gmail.com>
Cc: trivial@kernel.org, linux-zigbee-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-wpan@vger.kernel.org

Hi Julien,

On Wed, Oct 01, 2014 at 12:06:58PM +0200, Julien Catalano wrote:
> Signed-off-by: Julien Catalano <julien.catalano@gmail.com>
> ---
>  net/mac802154/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/mac802154/Kconfig b/net/mac802154/Kconfig
> index 1818a99..aa462b4 100644
> --- a/net/mac802154/Kconfig
> +++ b/net/mac802154/Kconfig
> @@ -16,5 +16,5 @@ config MAC802154
>  	  been tested yet!
>  
>  	  If you plan to use HardMAC IEEE 802.15.4 devices, you can
> -	  say N here. Alternatievly you can say M to compile it as
> +	  say N here. Alternatively you can say M to compile it as
>  	  module.

Applied this to wpan-next. Thanks.

btw. project mailinglist changed to [0].

- Alex

[0] http://vger.kernel.org/vger-lists.html#linux-wpan
