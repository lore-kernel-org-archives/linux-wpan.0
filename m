Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:33581 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752299AbcKVMOd (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 22 Nov 2016 07:14:33 -0500
MIME-Version: 1.0
In-Reply-To: <628fdbf2-7600-b176-f896-08f26318048d@pengutronix.de>
References: <20160807143056.3116-1-aar@pengutronix.de> <628fdbf2-7600-b176-f896-08f26318048d@pengutronix.de>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 22 Nov 2016 14:14:31 +0200
Message-ID: <CABBYNZ+3yU7zb5iHreh6HqZ1X3Zq8dEEJY4MYGxLMu6Y71NmKw@mail.gmail.com>
Subject: Re: [RFCv2 bluetooth-next 00/19] bluetooth: rework 6lowpan implementation
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de, "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>

Hi Alex,

On Mon, Aug 8, 2016 at 3:10 PM, Alexander Aring <aar@pengutronix.de> wrote:
> Hi,
>
> On 08/07/2016 04:30 PM, Alexander Aring wrote:
>> Hi,
>>
>> This patch series is my second RFC for making btle 6lowpan into the right
>> direction.
>>
>> I added hopefully all suggestions which I got from RFCv1. The interface address
>> will be assigned when the first l2cap chan connection gets in. This device
>> address will be get by "hci_copy_identity_address" bluetooth API function and
>> I hope this is the right function to get the "RPA device address".

Well this does not work is identity address might not be the same as
RPA, using hci_copy_identity_address might leak the identity address
to other peer participating in the network.

>> Checkout commit message of Patch 19/19 to see how I used it.
>>
>> Bad news are, I will start my master thesis shortly so I am not able to work
>> on this patch series anymore.
>>

Did you keep track what patches have been merged upstream? Id like to
first make the solution stable since even pings something makes the
kernel crash, so how about those:

  bluetooth: introduce l2cap_hdev_chan_connect
  bluetooth: add hci dev notifier
  bluetooth: introduce l2cap chan priv data
  bluetooth: export functions and variables

> and I got the following warnings from bots/persons, I just send it here
> again for the next person who like to work on that or I forget it again
> the next time when I can work on this:
>
> "ERROR: "baswap" [net/6lowpan/6lowpan.ko] undefined!"
>
> This is because baswap is some compiled function in bluetooth module and
> 6lowpan doesn;t depend on that.
>
> Another issue:
>
> net/bluetooth/6lowpan.c:892:0-23: WARNING: lowpan_enabled_fops should be
> defined with DEFINE_DEBUGFS_ATTRIBUTE
>
>  Use DEFINE_DEBUGFS_ATTRIBUTE rather than DEFINE_SIMPLE_ATTRIBUTE
>   for debugfs files.
>
> which seems to be also affected in net/6lowpan/debugfs.c and
> net/bluetooth/hci_debugfs.c
>
> - Alex
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
