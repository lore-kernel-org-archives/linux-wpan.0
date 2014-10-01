Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:37814 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751056AbaJAILL (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 1 Oct 2014 04:11:11 -0400
Received: by mail-wg0-f47.google.com with SMTP id x13so405246wgg.30
        for <linux-wpan@vger.kernel.org>; Wed, 01 Oct 2014 01:11:09 -0700 (PDT)
Date: Wed, 1 Oct 2014 10:11:04 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: Problems with fakeserial
Message-ID: <20141001081102.GA25131@omega>
References: <542ACF52.3030807@xsilon.com>
 <20141001003814.GB1007@omega>
 <542BB5B1.5010705@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <542BB5B1.5010705@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Martin Townsend <martin.townsend@xsilon.com>
Cc: linux-wpan@vger.kernel.org

Hi Martin,

On Wed, Oct 01, 2014 at 09:05:05AM +0100, Martin Townsend wrote:
> Hi Alex,
> 
> Do you know where I can find the serial driver module?
> 

yes, the last known version for me is this what Tony Chenau did. [0]

If the rework is finish, we should think about a serial protocol
specification and a mainlineable driver.


And now the funny part:
Then I would write a contiki app which allow to talk this protocol, then
you use contiki as firmware. Then you would use contiki for that you
don't using contiki 802.15.4/6LoWPAN stack anymore. :D

- Alex

[0] https://github.com/linux-wpan/linux-wpan-next/commit/546618171de2be30236aab86f3ee323b425e2bf5
