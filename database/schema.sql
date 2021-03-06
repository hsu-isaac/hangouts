set client_min_messages to warning;

-- DANGER: this is NOT how to do it in the real world.
-- `drop schema` INSTANTLY ERASES EVERYTHING.
drop schema "public" cascade;

create schema "public";

CREATE TABLE "public"."user" (
	"userId" serial NOT NULL,
	"name" TEXT NOT NULL UNIQUE,
	"googleId" TEXT NOT NULL UNIQUE,
	CONSTRAINT "user_pk" PRIMARY KEY ("userId")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public"."events" (
	"eventId" serial NOT NULL,
	"userId" integer NOT NULL,
	"eventName" TEXT NOT NULL,
	"dateTime" timestamp with time zone NOT NULL,
	"description" TEXT NOT NULL,
	"location" point NOT NULL,
	"imageUrl" TEXT NOT NULL,
	CONSTRAINT "events_pk" PRIMARY KEY ("eventId")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public"."invites" (
	"eventId" integer NOT NULL,
	"userId" integer NOT NULL,
	"response" BOOLEAN
) WITH (
  OIDS=FALSE
);




ALTER TABLE "events" ADD CONSTRAINT "events_fk0" FOREIGN KEY ("userId") REFERENCES "user"("userId");

ALTER TABLE "invites" ADD CONSTRAINT "invites_fk0" FOREIGN KEY ("eventId") REFERENCES "events"("eventId");
ALTER TABLE "invites" ADD CONSTRAINT "invites_fk1" FOREIGN KEY ("userId") REFERENCES "user"("userId");
