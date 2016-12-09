Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:39482
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932449AbcLIImu (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 9 Dec 2016 03:42:50 -0500
Subject: Re: [PATCH v6 0/3] ieee802154: Add support for Cascoda CA8210
References: <20161206154740.2992-1-h.morris@cascoda.com>
 <EE6B2599-12C7-4B55-AFA5-E88C6BF8A942@holtmann.org>
 <d45202f9-71ee-4be3-c7e4-f60d5fa07fb7@cascoda.com>
 <986A108D-949B-45B7-A6F0-3FBFFDEAAD59@holtmann.org>
 <44972b71-dcc5-6464-12bd-0156c2750f0e@cascoda.com>
 <CC9821E1-92A1-4112-A5F9-22F36D2EA398@holtmann.org>
 <54150f82-d69c-4baa-2a4b-56e094f89013@osg.samsung.com>
 <C365DB7F-B34C-465C-ABCD-FC05F2DAB8E2@holtmann.org>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <751c9697-5e9d-f2db-2dfb-8c6573d75746@osg.samsung.com>
Date: Fri, 9 Dec 2016 09:42:44 +0100
MIME-Version: 1.0
In-Reply-To: <C365DB7F-B34C-465C-ABCD-FC05F2DAB8E2@holtmann.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Harry Morris <h.morris@cascoda.com>, harrymorris12@gmail.com, linux-wpan@vger.kernel.org, Alexander Aring <aar@pengutronix.de>

Hello.

On 09/12/16 09:22, Marcel Holtmann wrote:
> Hi Stefan,
>
>>>>> I do not see myself in the CC list and I got 2/3 and 3/3 via linux-wpan mailing list.
>>>>>
>>>> That's bizarre, am I missing something about how emails work?
>>>>
>>>> From: harrymorris12@gmail.com
>>>>
>>>> X-Google-Original-From:
>>>> h.morris@cascoda.com
>>>>
>>>> To:
>>>> linux-wpan@vger.kernel.org
>>>>
>>>> Cc:
>>>> aar@pengutronix.de
>>>> ,
>>>> 	
>>>> stefan@osg.samsung.com
>>>> ,
>>>> 	
>>>> marcel@holtmann.org
>>>> ,
>>>> 	Harry Morris
>>>> <h.morris@cascoda.com>
>>>>
>>>> Subject: [PATCH v6 1/3] ieee802154: Add CA8210 IEEE 802.15.4 device driver
>>>> Date: Tue,  6 Dec 2016 15:47:38 +0000
>>>>
>>>> I've forwarded the original to your address individually, please let me know if you receive it.
>>>
>>> I got the forwarded one, but not the other. And as you can see in my Reply-All, I was not on the CC list. Anyhow, either the forwarded one got mangled or it does not apply clean to bluetooth-next tree. Please fix that re-submit.
>>
>>
>> As an alternative to ease things up here you could go with the following pull request which has the 3 patches from harry on top of your latest pull request to DaveM. They applied and compiled cleanly here for me. If you wanna take this one or wait for the re-submit from Harry is up to you. Just thought it might be worth preparing this as I already had the patches in my tree for testing. :)
>>
>> The following changes since commit 107bc0aa95ca572df42da43c30a2079266e992e4:
>>
>>  Merge branch 'for-upstream' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next (2016-12-08 14:33:17 -0500)
>>
>> are available in the git repository at:
>>
>>  https://github.com/linux-wpan/linux-wpan-next.git for-next
>>
>> for you to fetch changes up to c8e4b45529a0d608b50f93cc54e03e749fab67af:
>>
>>  ieee802154: Add entry in MAINTAINTERS for CA8210 driver (2016-12-09 08:35:12 +0100)
>>
>> ----------------------------------------------------------------
>> Harry Morris (3):
>>      ieee802154: Add CA8210 IEEE 802.15.4 device driver
>>      ieee802154: Add device tree documentation for CA8210
>>      ieee802154: Add entry in MAINTAINTERS for CA8210 driver
>>
>> Documentation/devicetree/bindings/net/ieee802154/ca8210.txt |   28 +
>> Documentation/devicetree/bindings/vendor-prefixes.txt       |    1 +
>> MAINTAINERS                                                 |    9 +
>> drivers/net/ieee802154/Kconfig                              |   21 +
>> drivers/net/ieee802154/Makefile                             |    1 +
>> drivers/net/ieee802154/ca8210.c                             | 3719 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>> 6 files changed, 3779 insertions(+)
>> create mode 100644 Documentation/devicetree/bindings/net/ieee802154/ca8210.txt
>> create mode 100644 drivers/net/ieee802154/ca8210.c
>
>   CC      drivers/net/ieee802154/ca8210.o
> drivers/net/ieee802154/ca8210.c: In function ‘ca8210_test_int_user_write’:
> drivers/net/ieee802154/ca8210.c:2878:50: warning: format ‘%d’ expects argument of type ‘int’, but argument 3 has type ‘size_t {aka long unsigned int}’ [-Wformat=]
>     "userspace requested erroneously long write (%d)\n",
>                                                   ^
> drivers/net/ieee802154/ca8210.c: In function ‘ca8210_register_ext_clock’:
> drivers/net/ieee802154/ca8210.c:3159:14: error: implicit declaration of function ‘clk_register_fixed_rate’ [-Werror=implicit-function-declaratio]
>   priv->clk = clk_register_fixed_rate(
>               ^~~~~~~~~~~~~~~~~~~~~~~
> drivers/net/ieee802154/ca8210.c:3159:12: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
>   priv->clk = clk_register_fixed_rate(
>             ^
> drivers/net/ieee802154/ca8210.c:3171:8: error: implicit declaration of function ‘of_clk_add_provider’ [-Werror=implicit-function-declaration]
>   ret = of_clk_add_provider(np, of_clk_src_simple_get, priv->clk);
>         ^~~~~~~~~~~~~~~~~~~
> drivers/net/ieee802154/ca8210.c:3171:32: error: ‘of_clk_src_simple_get’ undeclared (first use in this function)
>   ret = of_clk_add_provider(np, of_clk_src_simple_get, priv->clk);
>                                 ^~~~~~~~~~~~~~~~~~~~~
> drivers/net/ieee802154/ca8210.c:3171:32: note: each undeclared identifier is reported only once for each function it appears in
> drivers/net/ieee802154/ca8210.c:3173:3: error: implicit declaration of function ‘clk_unregister’ [-Werror=implicit-function-declaration]
>    clk_unregister(priv->clk);
>    ^~~~~~~~~~~~~~
> drivers/net/ieee802154/ca8210.c: In function ‘ca8210_unregister_ext_clock’:
> drivers/net/ieee802154/ca8210.c:3197:2: error: implicit declaration of function ‘of_clk_del_provider’ [-Werror=implicit-function-declaration]
>   of_clk_del_provider(spi->dev.of_node);
>   ^~~~~~~~~~~~~~~~~~~
> drivers/net/ieee802154/ca8210.c:3197:2: warning: ‘return’ with a value, in function returning void
>   of_clk_del_provider(spi->dev.of_node);
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/net/ieee802154/ca8210.c:3190:13: note: declared here
>  static void ca8210_unregister_ext_clock(struct spi_device *spi)
>              ^~~~~~~~~~~~~~~~~~~~~~~~~~~


Grr, this should not happen when I send you things. Sorry. One step back.

Harry, please fix this warnings and errors.

And I will have to see why I did not see them and improve my build tests 
here to spot them next time.

regards
Stefan Schmidt
