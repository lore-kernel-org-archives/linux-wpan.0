Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:53714 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752677AbbKLItU (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Thu, 12 Nov 2015 03:49:20 -0500
Received: from [192.168.2.22] (pD9F79E8A.dip0.t-ipconnect.de [217.247.158.138])
	by lists.s-osg.org (Postfix) with ESMTPSA id 549D5462B3
	for <linux-wpan@vger.kernel.org>; Thu, 12 Nov 2015 00:49:19 -0800 (PST)
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: Automated building infrastructure for wpan-tools now active
Message-ID: <5644528D.4060305@osg.samsung.com>
Date: Thu, 12 Nov 2015 09:49:17 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>

Hello.

I tokk some time to setup an automated build for every push to our 
wpan-tools repo.
As we are using GitHub I went with Travis CI which tightly integrates 
with Github and
solves the problem for us without running our own hardware.

https://travis-ci.org/linux-wpan/wpan-tools

For now we only do compile testing with gcc and clang. If someone has an 
interest to
extend this let me know.

Another functionality we use from Travis is the automated submit of 
builds to the
Coverity Scan service to run a static analysis over our code. This 
already found some
small issues which are fixed now.

https://scan.coverity.com/projects/linux-wpan-wpan-tools/

We do only submit pushes to a branch called coverity_scan. This avoids 
the overkill
of submitting every push to master and also helps to submit our code 
before it even
hits master. You should be able to register at Coverity and request 
access to our
defects if you want to see what is going on there. Nothing to do right 
now but that
could change. :)

regards
Stefan Schmidt
