Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from cs43706557.123-cloud-server.co.uk ([91.109.11.113]:49959 "EHLO
        cascoda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932193AbdBPRSO (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Thu, 16 Feb 2017 12:18:14 -0500
Reply-To: h.morris@cascoda.com
Subject: Re: [PATCH v8 0/3] ieee802154: Add support for Cascoda CA8210
References: <20170206170857.5064-1-h.morris@cascoda.com>
 <3E93277B-2B5C-402A-A683-2E94ADEC038F@holtmann.org>
From: Harry Morris <h.morris@cascoda.com>
Message-ID: <9b21db69-6034-4e01-28f0-852ea75d4bd5@cascoda.com>
Date: Thu, 16 Feb 2017 17:18:09 +0000
MIME-Version: 1.0
In-Reply-To: <3E93277B-2B5C-402A-A683-2E94ADEC038F@holtmann.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Harry Morris <harrymorris12@gmail.com>, linux-wpan@vger.kernel.org, aar@pengutronix.de, Stefan Schmidt <stefan@osg.samsung.com>

Hi Marcel,

On 16/02/2017 16:50, Marcel Holtmann wrote:
> Hi Harry,
>
>> This patchset adds a new device driver, documentation and build support for
>> Cascoda's CA8210 IEEE 802.15.4 radio transceiver:
>> http://www.cascoda.com/products/ca-821x/
>>
>> v8:
>> Use module_spi_driver helper
>> Remove async tx timeout at driver level
>> Style conformance change
>> Rework synchronous command handling to remove mutex
>>
>> v7:
>> Remove use of cs_change property, always transmit full length buffers
>> Implement fully async spi transfers
>> Combine spi transmission and reception into one function
>> Use completion objects when waiting for events
>> Rework a lot of locking
>> Remove deprecated xmit_sync
>> Remove use of workqueue for IRQ handling
>>
>> v6:
>> Kernel style conformance changes
>> Additional documentation
>> More meaningful register structs/macros
>> Removal of old TODOs
>> Removal of unnecessary macros
>> Check for safe removal of test interface
>>
>> v5:
>> +Cc: Marcel Holtmann
>>
>> v4:
>> Added allowable tx_powers and cca_ed_levels
>> Changed power units to mbm (tx_power & cca_ed_level)
>>
>> Harry Morris (3):
>>   ieee802154: Add CA8210 IEEE 802.15.4 device driver
>>   ieee802154: Add device tree documentation for CA8210
>>   ieee802154: Add entry in MAINTAINTERS for CA8210 driver
>>
>> .../devicetree/bindings/net/ieee802154/ca8210.txt  |   28 +
>> .../devicetree/bindings/vendor-prefixes.txt        |    1 +
>> MAINTAINERS                                        |    9 +
>> drivers/net/ieee802154/Kconfig                     |   21 +
>> drivers/net/ieee802154/Makefile                    |    1 +
>> drivers/net/ieee802154/ca8210.c                    | 3155 ++++++++++++++++++++
>> 6 files changed, 3215 insertions(+)
>> create mode 100644 Documentation/devicetree/bindings/net/ieee802154/ca8210.txt
>> create mode 100644 drivers/net/ieee802154/ca8210.c
>    CC      drivers/net/ieee802154/ca8210.o
> drivers/net/ieee802154/ca8210.c: In function ‘ca8210_register_ext_clock’:
> drivers/net/ieee802154/ca8210.c:2698:14: error: implicit declaration of function ‘clk_register_fixed_rate’ [-Werror=implicit-function-declaratio]
>    priv->clk = clk_register_fixed_rate(
>                ^~~~~~~~~~~~~~~~~~~~~~~
> drivers/net/ieee802154/ca8210.c:2698:12: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
>    priv->clk = clk_register_fixed_rate(
>              ^
> drivers/net/ieee802154/ca8210.c:2710:8: error: implicit declaration of function ‘of_clk_add_provider’ [-Werror=implicit-function-declaration]
>    ret = of_clk_add_provider(np, of_clk_src_simple_get, priv->clk);
>          ^~~~~~~~~~~~~~~~~~~
> drivers/net/ieee802154/ca8210.c:2710:32: error: ‘of_clk_src_simple_get’ undeclared (first use in this function)
>    ret = of_clk_add_provider(np, of_clk_src_simple_get, priv->clk);
>                                  ^~~~~~~~~~~~~~~~~~~~~
> drivers/net/ieee802154/ca8210.c:2710:32: note: each undeclared identifier is reported only once for each function it appears in
> drivers/net/ieee802154/ca8210.c:2712:3: error: implicit declaration of function ‘clk_unregister’ [-Werror=implicit-function-declaration]
>     clk_unregister(priv->clk);
>     ^~~~~~~~~~~~~~
> drivers/net/ieee802154/ca8210.c: In function ‘ca8210_unregister_ext_clock’:
> drivers/net/ieee802154/ca8210.c:2736:2: error: implicit declaration of function ‘of_clk_del_provider’ [-Werror=implicit-function-declaration]
>    of_clk_del_provider(spi->dev.of_node);
>    ^~~~~~~~~~~~~~~~~~~
> drivers/net/ieee802154/ca8210.c:2736:2: warning: ‘return’ with a value, in function returning void
>    of_clk_del_provider(spi->dev.of_node);
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/net/ieee802154/ca8210.c:2729:13: note: declared here
>   static void ca8210_unregister_ext_clock(struct spi_device *spi)
>               ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>
I remember these same issues being raised previously and found the old 
exchange:

> Hi Stefan, Marcel,
>
> Apologies for the slow reply, I've been snowed under the past week or 
> so...
>
> On 09/12/2016 11:52, Stefan Schmidt wrote:
>> On 09/12/16 09:22, Marcel Holtmann wrote:
>>> drivers/net/ieee802154/ca8210.c: In function 
>>> ‘ca8210_register_ext_clock’:
>>> drivers/net/ieee802154/ca8210.c:3159:14: error: implicit declaration 
>>> of function ‘clk_register_fixed_rate’ 
>>> [-Werror=implicit-function-declaratio]
>>>   priv->clk = clk_register_fixed_rate(
>>>               ^~~~~~~~~~~~~~~~~~~~~~~
>>> drivers/net/ieee802154/ca8210.c:3159:12: warning: assignment makes 
>>> pointer from integer without a cast [-Wint-conversion]
>>>   priv->clk = clk_register_fixed_rate(
>>>             ^
>>> drivers/net/ieee802154/ca8210.c:3171:8: error: implicit declaration 
>>> of function ‘of_clk_add_provider’ 
>>> [-Werror=implicit-function-declaration]
>>>   ret = of_clk_add_provider(np, of_clk_src_simple_get, priv->clk);
>>>         ^~~~~~~~~~~~~~~~~~~
>>> drivers/net/ieee802154/ca8210.c:3171:32: error: 
>>> ‘of_clk_src_simple_get’ undeclared (first use in this function)
>>>   ret = of_clk_add_provider(np, of_clk_src_simple_get, priv->clk);
>>>                                 ^~~~~~~~~~~~~~~~~~~~~
>>> drivers/net/ieee802154/ca8210.c:3171:32: note: each undeclared 
>>> identifier is reported only once for each function it appears in
>>> drivers/net/ieee802154/ca8210.c:3173:3: error: implicit declaration 
>>> of function ‘clk_unregister’ [-Werror=implicit-function-declaration]
>>>    clk_unregister(priv->clk);
>>>    ^~~~~~~~~~~~~~
>>> drivers/net/ieee802154/ca8210.c: In function 
>>> ‘ca8210_unregister_ext_clock’:
>>> drivers/net/ieee802154/ca8210.c:3197:2: error: implicit declaration 
>>> of function ‘of_clk_del_provider’ 
>>> [-Werror=implicit-function-declaration]
>>>   of_clk_del_provider(spi->dev.of_node);
>>>   ^~~~~~~~~~~~~~~~~~~
>>> drivers/net/ieee802154/ca8210.c:3197:2: warning: ‘return’ with a 
>>> value, in function returning void
>>>   of_clk_del_provider(spi->dev.of_node);
>>>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> drivers/net/ieee802154/ca8210.c:3190:13: note: declared here
>>>  static void ca8210_unregister_ext_clock(struct spi_device *spi)
>>>              ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> None of these showed up here. A #include <linux/clk-provider.h> 
>> should fix those imho.
>
> I'm also not seeing these, I am including <linux/clk-provider.h> in my 
> file, is there any action needed on my part?

I couldn't find any further discussion but again I'm including 
clk-provider.h which should cover all this?

Regards,
Harry
