Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:36845 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755969AbcKVQBy (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>);
        Tue, 22 Nov 2016 11:01:54 -0500
Subject: Re: [RFCv2 bluetooth-next 00/19] bluetooth: rework 6lowpan
 implementation
References: <20160807143056.3116-1-aar@pengutronix.de>
 <628fdbf2-7600-b176-f896-08f26318048d@pengutronix.de>
 <CABBYNZ+3yU7zb5iHreh6HqZ1X3Zq8dEEJY4MYGxLMu6Y71NmKw@mail.gmail.com>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <86ce20e0-24c2-9218-8482-74d892bd999f@pengutronix.de>
Date: Tue, 22 Nov 2016 16:41:54 +0100
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+3yU7zb5iHreh6HqZ1X3Zq8dEEJY4MYGxLMu6Y71NmKw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de, "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>

Hi,

On 11/22/2016 01:14 PM, Luiz Augusto von Dentz wrote:
> Hi Alex,
> 
> On Mon, Aug 8, 2016 at 3:10 PM, Alexander Aring <aar@pengutronix.de> wrote:
>> Hi,
>>
>> On 08/07/2016 04:30 PM, Alexander Aring wrote:
>>> Hi,
>>>
>>> This patch series is my second RFC for making btle 6lowpan into the right
>>> direction.
>>>
>>> I added hopefully all suggestions which I got from RFCv1. The interface address
>>> will be assigned when the first l2cap chan connection gets in. This device
>>> address will be get by "hci_copy_identity_address" bluetooth API function and
>>> I hope this is the right function to get the "RPA device address".
> 
> Well this does not work is identity address might not be the same as
> RPA, using hci_copy_identity_address might leak the identity address
> to other peer participating in the network.
> 

ok. Don't know, we need to talk about which address again. What I
changed in this patch series is that a interface will not be
unregistered when connection get lost (very bad for ip capable
interfaces), it's going down and when it's down it has no address until
it's up again. While the interface is up, you cannot change the L2 address.

So if 6LoWPAN interface is down, you can set which adress you want to
use on L2 bluetooth layer, at least it need to be known when somebody
makes the interface up. If all connection get lost -> interface will down.

So far I remember correctly I replace register/unregister when first
connection comes in/last connection get lost with ifup/ifdown. So the
interface comes automatically up when first connection is there, I
thought that because if connection is there then the L2 address cannot
be changed -> which is good.

And with connection I mean a L2CAP connection which you did before with
btmgt connect stuff + running echo "connect ..." on debugs interface.

Sorry, I don't know the special words which bluetooth community use that
to describe the differences.

>>> Checkout commit message of Patch 19/19 to see how I used it.
>>>
>>> Bad news are, I will start my master thesis shortly so I am not able to work
>>> on this patch series anymore.
>>>
> 
> Did you keep track what patches have been merged upstream? Id like to
> first make the solution stable since even pings something makes the
> kernel crash, so how about those:
> 
>   bluetooth: introduce l2cap_hdev_chan_connect
>   bluetooth: add hci dev notifier
>   bluetooth: introduce l2cap chan priv data
>   bluetooth: export functions and variables
>

the actual btle 6lowpan code is full with races. I agree I need to
cleanup the patch series to write what I fixed "a race" or "interface
address stateless autoconfiguration handling -> remove the FF:FE in MAC" or
"neighbor discovery -> don't recover MAC address from L3 -> this stuff is
complete broken, ipv6 is not designed to work as such handling". I think
these are the most important topics which we have in this patch-series.

Badly I am still in my thesis and have no time to do that. Sorry.

- Alex
