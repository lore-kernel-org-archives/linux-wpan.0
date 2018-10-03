Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:53465 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbeJCPBb (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 3 Oct 2018 11:01:31 -0400
Subject: Re: [PATCHv2 wpan-tools] wpan-hwsim: hardware simulator configuration
 utility
References: <20180930215234.4679-1-aring@mojatatu.com>
From: Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <d7ddf133-f8ff-e372-d722-14daa0de4545@datenfreihafen.org>
Date: Wed, 3 Oct 2018 10:14:09 +0200
MIME-Version: 1.0
In-Reply-To: <20180930215234.4679-1-aring@mojatatu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aring@mojatatu.com>
Cc: linux-wpan@vger.kernel.org

Hello.

On 30/09/2018 23:52, Alexander Aring wrote:
> This patch adds initial support for wpan-hwsim utility to control the
> mac802154_hwsim driver over netlink.
> 
> Signed-off-by: Alexander Aring <aring@mojatatu.com>
> ---
> 
> Forgot if I ever send v2 but my local change has the last complain.
> So I resend.
> 
> changes since v2:
> - help and version both do not need an argument, please use no_argument
> - printf("wpan-hwsim " PACKAGE_VERSION "\n");

Patch has been applied to wpan-tools. Thanks for fixing up my review
comments.

Seems we want to get out a new wpan-tools release in the next weeks to
have this utility available. I will see what I can do.

regards
Stefan Schmidt
