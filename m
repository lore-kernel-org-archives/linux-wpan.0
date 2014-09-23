Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:30790 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755410AbaIWOUr (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Tue, 23 Sep 2014 10:20:47 -0400
Message-ID: <1411482042.4860.81.camel@jrissane-mobl.ger.corp.intel.com>
Subject: Re: [PATCH linux-wpan v4] ieee802154: 6lowpan: ensure header
 compression does not corrupt ipv6 header
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Date: Tue, 23 Sep 2014 17:20:42 +0300
In-Reply-To: <20140923093544.GB12857@omega>
References: <1411401123-7790-1-git-send-email-simon.vincent@xsilon.com>
	 <20140922162148.GA7282@omega>
	 <1411463634.4860.65.camel@jrissane-mobl.ger.corp.intel.com>
	 <20140923092653.GA12857@omega> <20140923093544.GB12857@omega>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: Simon Vincent <simon.vincent@xsilon.com>, linux-wpan@vger.kernel.org, marcel@holtmann.org

Hi Alex,

On ti, 2014-09-23 at 11:35 +0200, Alexander Aring wrote:
> Jukka,
> 
> I/Simon mainly add you here in cc because this bug what Simon fixed here
> is also inside of bluetooth 6lowpan.
> 
> I see now [0]. And it seems to me that this also occurs at bluetooth
> branch. Do you have any questions on how the fix now is? Sorry, but I
> need to clarify that you understood this issue and you/others prepare a
> patch for this.

I was trying to test this issue and send multicast packets to Bluetooth
6lowpan until I realized that the interface does not have IFF_MULTICAST
enabled :) So this issue is not valid atm for Bluetooth.

Thanks for pointing this out.


Cheers,
Jukka


