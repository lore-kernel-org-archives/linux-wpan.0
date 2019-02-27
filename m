Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:34458 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727488AbfB0VvP (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 27 Feb 2019 16:51:15 -0500
Subject: Re: [PATCH 1/2] doc: net: ieee802154: introduce IEEE 802.15.4
 subsystem doc in rst style
References: <20190227195914.4594-1-stefan@datenfreihafen.org>
 <20190227195914.4594-2-stefan@datenfreihafen.org>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <12e09441-6666-7e59-d4c3-d950bec8721f@infradead.org>
Date: Wed, 27 Feb 2019 13:51:13 -0800
MIME-Version: 1.0
In-Reply-To: <20190227195914.4594-2-stefan@datenfreihafen.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@datenfreihafen.org>, davem@davemloft.net, corbet@lwn.net
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, linux-wpan@vger.kernel.org

On 2/27/19 11:59 AM, Stefan Schmidt wrote:
> Moving the ieee802154 docs from a plain text file into the new rst
> style. This commit only does the minimal needed change to bring the
> documentation over. Follow up patches will improve and extend on this.
> 
> Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
> ---
>  Documentation/networking/ieee802154.rst | 180 ++++++++++++++++++++++++
>  Documentation/networking/index.rst      |   1 +
>  2 files changed, 181 insertions(+)
>  create mode 100644 Documentation/networking/ieee802154.rst

Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

-- 
~Randy
