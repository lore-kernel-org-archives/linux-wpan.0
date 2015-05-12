Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from sssup.it ([193.205.80.95]:57536 "EHLO sssup.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752800AbbELJsi (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Tue, 12 May 2015 05:48:38 -0400
Message-ID: <5551CC74.60702@sssup.it>
Date: Tue, 12 May 2015 11:48:36 +0200
From: Matteo Petracca <matteo.petracca@sssup.it>
MIME-Version: 1.0
Subject: Re: Ieee802154 socket problem with SIOCGIFADDR
References: <554E1C92.7040306@sssup.it> <20150509164227.GA694@omega> <5550DC2D.5060909@sssup.it> <20150511175141.GA7965@omega> <5551BAB9.9000101@sssup.it> <20150512083917.GC733@omega>
In-Reply-To: <20150512083917.GC733@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

You were right, I did not remove the Assertion.

Now the patch is all there and the modules are
updated.

What happens now is a strange behaviour, booting
the system I just turn on the wpan interface putting
as panid 0xaaaa:

ifconfig wpan0 up

the device starts to read from the network, and this is
what I have in output with dmesg is:

[  131.445285] ieee802154: bad frame received (type = 3)
[  133.777933] ieee802154: bad frame received (type = 3)
[  136.110635] ieee802154: bad frame received (type = 3)
[  148.318471] ieee802154: bad frame received (type = 3)
[  150.651288] ieee802154: bad frame received (type = 3)
[  152.984910] ieee802154: bad frame received (type = 3)
[  165.195277] ieee802154: bad frame received (type = 3)
[  167.527936] ieee802154: bad frame received (type = 3)
[  169.860422] ieee802154: bad frame received (type = 3)
[  182.071635] ieee802154: bad frame received (type = 3)
[  184.406857] ieee802154: bad frame received (type = 3)
[  186.739487] ieee802154: bad frame received (type = 3)
[  198.947054] ieee802154: bad frame received (type = 3)
[  201.279710] ieee802154: bad frame received (type = 3)
[  203.612262] ieee802154: bad frame received (type = 3)
[  215.819843] ieee802154: bad frame received (type = 3)
[  218.155852] ieee802154: bad frame received (type = 3)
[  220.488465] ieee802154: bad frame received (type = 3)

Moreover SIOCGIFADDR still does not work.

Sorry for bothering you.

I don't know what to think.

Matteo

On 12/05/2015 10:39, Alexander Aring wrote:
> On Tue, May 12, 2015 at 10:32:57AM +0200, Matteo Petracca wrote:
>> I've applied your patch properly.
>>
>> By using your example this is what I have with kernel 4.0.2 for
>> beagleboneblack
>>
>> [   44.362497] NET: Registered protocol family 36
>> [   44.369646] RTNL: assertion failed at net/mac802154/iface.c (65)
> can't be. The patch removes the RTNL assertion. Please check if you
> really rebuild and update your kernel/modules.
>
> Maybe try `uname -a` and check kernels build date/git HEAD id/whatever.
>
> - Alex
> --
> To unsubscribe from this list: send the line "unsubscribe linux-wpan" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

