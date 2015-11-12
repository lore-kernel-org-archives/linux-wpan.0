Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:53713 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750765AbbKLIji (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Thu, 12 Nov 2015 03:39:38 -0500
Subject: Re: [PATCH wpan-tools 0/4] Coverity fixes for wpan-ping
References: <1447191756-15928-1-git-send-email-stefan@osg.samsung.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <56445044.60901@osg.samsung.com>
Date: Thu, 12 Nov 2015 09:39:32 +0100
MIME-Version: 1.0
In-Reply-To: <1447191756-15928-1-git-send-email-stefan@osg.samsung.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

Hello.

On 10/11/15 22:42, Stefan Schmidt wrote:
> Hello.
>
> I finished setting up Travis CI for builds and Coverity Scan service for wpan-tools on a private
> GitHub fork. If nobody has a strong opinion against this I would like to set it up on the main repo
> so we can have a first step towards some automated QA infrastructure.

This is done now. Will send a separate mail with more details about it.

> But lets first have a look at the results from this first run. As you can see on the our first
> run revealed 4 defects in 23321 lines of code (after the C preprocessor). With a defect density
> of 0.17 this is way below industry average which is set to one here. In other words this means
> we only have 1.7 defects per 10000 lines of code.
>
> Three of these have been problems in error pathes of the code (leak, no check on return value, etc)
> and one have been a false positive in the main iwpan.c file. Coverity was not able to understand
> that we set err in our netlinks callbacks and thought this code bit would never stop as we start
> with err = 1
>
> while (err > 0)
> 	nl_recvmsgs(state->nl_sock, cb);
>
> I marked it as false positive and fixed the remaining three defects with the patches below.
>
> Stefan Schmidt (4):
>    wpan-ping: remove unused struct sockaddr_nl variable
>    wpan-ping: check return value for setsockopt
>    wpan-ping: do not try to send data back to origin if we got an error
>      from recvfrom
>    wpan-ping: avoid leaking socket handle on error path
>
>   wpan-ping/wpan-ping.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
>

Pushed these now.

regards
Stefan Schmidt
