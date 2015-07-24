Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:54262 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751009AbbGXPBZ (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Fri, 24 Jul 2015 11:01:25 -0400
Subject: Re: [PATCH bluetooth-next 0/2] ieee802154: multiple lowpan interface
 support and fix mac setting
References: <1437742905-5921-1-git-send-email-alex.aring@gmail.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <55B25342.3070005@osg.samsung.com>
Date: Fri, 24 Jul 2015 17:01:22 +0200
MIME-Version: 1.0
In-Reply-To: <1437742905-5921-1-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org

Hello.

On 24/07/15 15:01, Alexander Aring wrote:
> Hi,
>
> this patch series contains two patches. At first we remove the multiple
> lowpan interface support. I don't see any use case for that, if somebody
> has an use case for it. Please report your use case.

I had to read the commit message to find out that you mean multiple 
lowpan interfaces on one wpan interface here. And not multiple lowpan 
interface on one machine which I thought first. :)

The later has for sure enough use cases :)

I don't have a use case for the former (the one you remove here) either. 
Still we might want to consider this as an RFC here to give folks a 
moment to speak up with they use this.

>
> Currently it's broken to update the wpan mac address while having a lowpan
> interface on the top. The first patch will introduce some easy mechanism
> to access the lowpan interface inside the lower mac802154 layer. When the
> mac802154 changes the mac address then it will updated also on the lowpan
> interface, if the wpan interface belongs to a lowpan interface.

Just back from vacation and catching up with to many things. I can give 
this a test on my setup next week if you want.

regards
Stefan Schmidt
