Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:56715 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753113AbcCWSk7 (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Wed, 23 Mar 2016 14:40:59 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: wpan-tools 0.6 release
Message-ID: <56F2E337.3040009@osg.samsung.com>
Date: Wed, 23 Mar 2016 19:40:55 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>
Cc: c.schoenert@t-online.de, pbrobinson@gmail.com

Hello.

It is a pleasure to announce the 0.6 release of wpan-tools.
Thanks to everyone who contributed!

0.6 is a bug fix release only. Some smaller things all over the place. 
The important one is a fix to work with libnl  >= 3.2.27 which is 
getting picked up by more and more distributions.

Downloads and md5sums:

http://wpan.cakelab.org/releases/wpan-tools-0.6.tar.bz2
dd5367fe36ad8269263a29edad073bf7

http://wpan.cakelab.org/releases/wpan-tools-0.6.tar.gz
05322b1bc2fcdc040d326f0a5017aa4e

Carsten Schoenert (1):
       iwpan: fix small typo, no functional change

Stefan Schmidt (18):
       wpan-ping: align wpan-ping version with the general wpan-tools 
version
       wpan-ping: remove no longer used b option from getopt string
       wpan-ping: fix usage message and mention -h option
       wpan-ping: use correct define to fix getopt_long usage
       wpan-ping: fix segfault for accessing invalid address
       build: avoid redefinition errors with libnl >= 3.2.27
       wpan-ping: remove unused struct sockaddr_nl variable
       wpan-ping: check return value for setsockopt
       wpan-ping: do not try to send data back to origin if we got an 
error from recvfrom
       wpan-ping: avoid leaking socket handle on error path
       ci build: start to use Travis CI for continuous integration builds
       ci build: add Coverity Scan service support to pur Travis config
       wpan-ping: hide packet dump behind DEBUG flag
       iwpan/wpan-ping: add some missing static attributes
       wpan-ping: remove unused parameter from init_server()
       wpan-ping: make sure we do not leak conf during wrong options exit
       travis: add IRC notification of travis builds to linux-wpan channel
       Release 0.6

regards
Stefan Schmidt
