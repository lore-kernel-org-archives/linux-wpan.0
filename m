Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:60027
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932187AbcKGQSC (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 7 Nov 2016 11:18:02 -0500
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: Re: [PATCH v3 0/3] ieee802154: Add support for Cascoda CA8210
References: <20161103155100.8400-1-h.morris@cascoda.com>
Message-ID: <2c5ab3b3-6cb8-c3fc-f069-748263a70069@osg.samsung.com>
Date: Mon, 7 Nov 2016 17:17:58 +0100
MIME-Version: 1.0
In-Reply-To: <20161103155100.8400-1-h.morris@cascoda.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: harrymorris12@gmail.com, linux-wpan@vger.kernel.org
Cc: alex.aring@gmail.com, Harry Morris <h.morris@cascoda.com>

Hello.

On 03/11/16 16:50, harrymorris12@gmail.com wrote:
> From: Harry Morris <h.morris@cascoda.com>
>
> This patchset adds a new device driver, documentation and build support for
> Cascoda's CA8210 IEEE 802.15.4 radio transceiver:
> http://www.cascoda.com/products/ca-821x/
>
> Harry Morris (3):
>   ieee802154: Add CA8210 IEEE 802.15.4 device driver
>   ieee802154: Add device tree documentation for CA8210
>   ieee802154: Add entry in MAINTAINTERS for CA8210 driver
>
>  .../devicetree/bindings/net/ieee802154/ca8210.txt  |   28 +
>  .../devicetree/bindings/vendor-prefixes.txt        |    1 +
>  MAINTAINERS                                        |    9 +
>  drivers/net/ieee802154/Kconfig                     |   18 +
>  drivers/net/ieee802154/Makefile                    |    1 +
>  drivers/net/ieee802154/ca8210.c                    | 3648 ++++++++++++++++++++
>  6 files changed, 3705 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/ieee802154/ca8210.txt
>  create mode 100644 drivers/net/ieee802154/ca8210.c

Thanks for rebasing. The patches apply fine for me now.

Also good to see the versioning of the patchset. Another hint would be 
to explain the changes from one version to another in the cover letter e.g.:

V5:
o Fixed foo bar

That helps reviewers to keep track.

regards
Stefan Schmidt
