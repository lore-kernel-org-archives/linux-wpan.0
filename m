Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from tuna.sandelman.ca ([209.87.249.19]:49015 "EHLO
	tuna.sandelman.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754541AbcCDUQr (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 4 Mar 2016 15:16:47 -0500
From: Michael Richardson <mcr@sandelman.ca>
Subject: Re: 802.15.4G support?
In-Reply-To: <20160304163749.GA21798@omega>
References: <CAH+RWqF-3Q8P52PTM9ZqpybEWTCKiubQK0-Y7L=c-3vAMhJfrg@mail.gmail.com> <20160228140659.GA17980@omega> <28981.1457015214@obiwan.sandelman.ca> <20160304083528.GA1525@omega> <24416.1457106776@obiwan.sandelman.ca> <20160304163749.GA21798@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <15461.1457122604.1@obiwan.sandelman.ca>
Date: Fri, 04 Mar 2016 15:16:44 -0500
Message-ID: <15462.1457122604@obiwan.sandelman.ca>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: Remi Philippe <remi@linqio.com>, linux-wpan@vger.kernel.org

Alexander Aring <alex.aring@gmail.com> wrote:
    > Okay. I think at first normal 127-bytes frames need to be send. After
    > if you are sure that your "neighbor" uses a "SUN Phy" then you need to
    > change the MTU (during runtime) for this special neighbor so a
    > different handling can be done.

Exactly... ND messages fit nicely in 127 bytes, and so the reply could
say something.

--
]               Never tell me the odds!                 | ipv6 mesh networks [
]   Michael Richardson, Sandelman Software Works        | network architect  [
]     mcr@sandelman.ca  http://www.sandelman.ca/        |   ruby on rails    [

