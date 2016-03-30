Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:59322 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751394AbcC3U65 (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Wed, 30 Mar 2016 16:58:57 -0400
Subject: Re: No device found for binding socket ieee802.15.4
References: <CALqexQVqxwfKxZ=fmtjQPnHcdibVFmFTG4dRZkBwC4aJfLkE5A@mail.gmail.com>
 <20160329083732.GA1114@omega>
 <CALqexQUhA-wTJow59_PkkbnmJz8UWxW2WoCdU=qYHYNQjyMVvQ@mail.gmail.com>
 <56FB8E7F.70106@osg.samsung.com>
 <CALqexQWw4QuPWxTDe8SdHxeOptq6TCf-O4Mq_UL-pDxqUz=h1A@mail.gmail.com>
 <56FC3A38.7030305@osg.samsung.com>
 <CALqexQV2z5wR3y8pUtWeF0eENyo3v6pdak6sm09g7LcPuQ+4cA@mail.gmail.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <56FC3E0D.7060604@osg.samsung.com>
Date: Wed, 30 Mar 2016 22:58:53 +0200
MIME-Version: 1.0
In-Reply-To: <CALqexQV2z5wR3y8pUtWeF0eENyo3v6pdak6sm09g7LcPuQ+4cA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Adika Bintang Sulaeman <adikabintang78@gmail.com>
Cc: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org, jukka.rissanen@linux.intel.com

Hello.

On 30/03/16 22:49, Adika Bintang Sulaeman wrote:
>> I still don't see why you would need to do this. What did you change?
> Sorry, I think I didn't explain clearly. I forgot to set pan_id and
> short address. Now the wpan-ping works fine. I tried to create a
> server program which is based on 802.15.4 and 6LoWPAN, and I imitate
> the code from wpan-ping. I didn't mean that I literally changed the
> wpan-ping.

OK, that makes more sense now. Without the address being setup this 
would fail.

>> Its the normal IPv6 socket API of linux.
> Thank you for your explanation, Stefan Schmidt.

If you have no specific requirements for the 6LoWPAN part normal 
client/server code written for the Linux IPv6 socket API should work 
over the lowpan0 interface.

regards
Stefan Schmidt
