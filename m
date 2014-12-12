Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:37922 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967792AbaLLNrg (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 12 Dec 2014 08:47:36 -0500
Received: by mail-wg0-f44.google.com with SMTP id b13so9106773wgh.17
        for <linux-wpan@vger.kernel.org>; Fri, 12 Dec 2014 05:47:35 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH wpan-misc] website: introduce asciidoc website generation framework
Date: Fri, 12 Dec 2014 14:47:28 +0100
Message-Id: <1418392049-11101-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

Hi,

this series introduce some files to build some website with asciidoc.
Feel free to add own information and then we simple update the website of
http://wpan.cakelab.org/.

- Alex

Alexander Aring (1):
  website: inital commit

 website/.gitingore |   1 +
 website/Makefile   |   5 +++
 website/index.txt  | 128 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 134 insertions(+)
 create mode 100644 website/.gitingore
 create mode 100644 website/Makefile
 create mode 100644 website/index.txt

-- 
2.1.3

