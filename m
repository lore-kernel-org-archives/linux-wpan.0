Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:43077
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751375AbdHGNKy (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 7 Aug 2017 09:10:54 -0400
Subject: Re: [PATCH] doc: linux-wpan: Change the old function names to the
 lastest function names
References: <20170806162829.2540-1-starnight@g.ncu.edu.tw>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <dff5d202-4096-2608-8ab1-90b5848535ce@osg.samsung.com>
Date: Mon, 7 Aug 2017 15:10:49 +0200
MIME-Version: 1.0
In-Reply-To: <20170806162829.2540-1-starnight@g.ncu.edu.tw>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Jian-Hong Pan <starnight@g.ncu.edu.tw>, Alexander Aring <aar@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-wpan@vger.kernel.org

Hello.

On 08/06/2017 06:28 PM, Jian-Hong Pan wrote:
> The function declaration in the lastest include/net/mac802154.h has been
> changed since v3.19.
> 
> ieee802154_alloc_device => ieee802154_alloc_hw
> ieee802154_free_device => ieee802154_free_hw
> ieee802154_register_device => ieee802154_register_hw
> ieee802154_unregister_device => ieee802154_unregister_hw
> 
> However, the description in the Device drivers API section of
> Documentation/networking/ieee802154.txt is still in the state of
> v3.18.63.
> 
> Signed-off-by: Jian-Hong Pan <starnight@g.ncu.edu.tw>
> ---
>   Documentation/networking/ieee802154.txt | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/networking/ieee802154.txt b/Documentation/networking/ieee802154.txt
> index 22bbc7225f8..ca1697a2273 100644
> --- a/Documentation/networking/ieee802154.txt
> +++ b/Documentation/networking/ieee802154.txt
> @@ -96,17 +96,17 @@ Device drivers API
>   ==================
>   
>   The include/net/mac802154.h defines following functions:
> - - struct ieee802154_dev *ieee802154_alloc_device
> -   (size_t priv_size, struct ieee802154_ops *ops):
> -   allocation of IEEE 802.15.4 compatible device
> + - struct ieee802154_hw *
> +   ieee802154_alloc_hw(size_t priv_data_len, const struct ieee802154_ops *ops):
> +   allocation of IEEE 802.15.4 compatible hardware device
>   
> - - void ieee802154_free_device(struct ieee802154_dev *dev):
> -   freeing allocated device
> + - void ieee802154_free_hw(struct ieee802154_hw *hw):
> +   freeing allocated hardware device
>   
> - - int ieee802154_register_device(struct ieee802154_dev *dev):
> -   register PHY in the system
> + - int ieee802154_register_hw(struct ieee802154_hw *hw):
> +   register PHY which is the allocated hardware device, in the system
>   
> - - void ieee802154_unregister_device(struct ieee802154_dev *dev):
> + - void ieee802154_unregister_hw(struct ieee802154_hw *hw):
>      freeing registered PHY
>   
>   Moreover IEEE 802.15.4 device operations structure should be filled.
> 

Acked-by: Stefan Schmidt <stefan@osg.samsung.com>

Thanks for fixing this!

regards
Stefan Schmidt
